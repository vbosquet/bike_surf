class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_booking_data, only: [:resume, :payment]

  def current_rentals
    @bookings = current_user.bookings.current
    @title = "Locations en cours"
    render :rentals
  end

  def past_rentals
    @bookings = current_user.bookings.past
    @title = "Anciennes locations"
    render :rentals
  end

  def upcoming_rentals
    @bookings = current_user.bookings.upcoming
    @title = "Locations à venir"
    render :rentals
  end

  def index
    @listing = Listing.find(params[:listing_id])
    @bookings = @listing.bookings

    available_dates = @bookings.dates.map do |d|
      {
        start: d.iso8601,
        allDay: true,
        rendering: 'background'
      }
    end

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: available_dates }
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @booking_pricing = @booking.listing.pricing.paper_trail.version_at(@booking.created_at)
    @listing = @booking.listing

    previous_bookings = @listing.bookings.where("created_at < ?", @booking.created_at)
    @days = previous_bookings.days(@booking.start_date, @booking.end_date)
    pricing_details(@booking_pricing)

    dates = (@booking.start_date.to_date..@booking.end_date.to_date).to_a
    available_dates = dates.select { |d| !previous_bookings.where.not(id: @booking.id).dates.include?(d) }.uniq
    available_dates = available_dates.map do |d|
      {
        start: d.iso8601,
        allDay: true,
        rendering: 'background'
      }
    end

    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: available_dates }
    end

  end

  def create
    @listing = Listing.find(params[:booking][:listing_id])

    if current_user.listings.include?(@listing)
      flash[:error] = "Vous ne pouvez pas réserver un vélo qui vous appartient déjà."
      redirect_to web_listing_path(@listing)
    end and return

    if checking_available_dates.present?
      flash[:error] = "Vous avez déjà loué un vélo aux dates suivantes : #{checking_available_dates}"
      redirect_to web_listing_path(@listing)
    end and return

    @booking = Booking.new(updating_messages_attributes)
    if @booking.save
      flash[:success] = "Votre réservation a été enregistrée avec succès."
			redirect_to web_listing_path(@listing)
    else
      flash[:error] = @booking.errors.values
      redirect_to listing_bookings_payment_path(listing_id: @listing,
        start_date: params[:booking][:start_date], end_date: params[:booking][:end_date])
    end
  end

  def update
    booking = Booking.find(params[:id])

    conversation = Conversation.find(params[:conversation_id])
    conversation.messages.create({conversation_id: conversation.id, user_id: current_user.id,
      body: params[:body], booking_id: booking.id})

    if params[:commit] == "Accepter"
      booking.booking_statuses.create({status: "accepted"})
    elsif params[:commit] == "Refuser"
      booking.booking_statuses.create({status: "refused"})
    end

    redirect_to conversation_path(conversation)
  end

  def resume
  end

  def payment
    @booking = Booking.new
    @booking.messages.build
    @booking.booking_statuses.build
  end

  private

  def booking_params
		params.require(:booking).permit(:listing_id, :start_date, :end_date, :total_price,
      messages_attributes: [:body, :conversation_id, :user_id],
      booking_statuses_attributes: [:status]).merge(user_id: current_user.id)
	end

  def find_booking_data
    @start_date = Time.parse(params[:start_date]) rescue nil
    @end_date = Time.parse(params[:end_date]) rescue nil
    @listing = Listing.find(params[:listing_id])
    if @start_date.present? && @end_date.present?
      @days = @listing.bookings.days(@start_date, @end_date)
      pricing_details(@listing.pricing)
    end
  end

  def pricing_details(pricing)
    base_price = @days * pricing.base_price
    @discount = 0
    if @days >= 7 && @days < 28
      @discount = base_price * (pricing.weekly_discount / 100.0)
    elsif @days >= 28
      @discount = base_price * (pricing.monthly_discount / 100.0)
    end
    @total_price = base_price - @discount + pricing.maintenance_fee
  end

  def checking_available_dates
    start_date = Time.parse(booking_params[:start_date])
    end_date = Time.parse(booking_params[:end_date])
    dates = (start_date.to_date..end_date.to_date).to_a
    disabled_dates = dates.select { |d| current_user.bookings.dates.include?(d) }.uniq
    return disabled_dates
  end

  def updating_messages_attributes
    conversations = Conversation.all.where('borrower_id = ? and lender_id = ?', current_user.id, @listing.user.id)
    if conversations.present?
      conversation = conversations.last
    else
      conversation = Conversation.create(borrower_id: current_user.id, lender_id: @listing.user.id)
    end

    params_updated = booking_params
    if params_updated[:messages_attributes].present?
      params_updated[:messages_attributes]["0"][:conversation_id] = conversation.id
      params_updated[:messages_attributes]["0"][:user_id] = current_user.id
    end
    return params_updated
  end

end
