class BookingsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :calculate_booking_data, only: [:calculate, :resume]

  def current_bookings
    @bookings = current_user.bookings.current
    @title = "Locations en cours"
    render :index
  end

  def past_bookings
    @bookings = current_user.bookings.past
    @title = "Anciennes locations"
    render :index
  end

  def upcoming_bookings
    @bookings = current_user.bookings.upcoming
    @title = "Locations à venir"
    render :index
  end


  def show
    @booking = Booking.find(params[:id])
    listing = @booking.listing
    previous_bookings = listing.bookings.where("created_at < ?", @booking.created_at)
    disabled_dates = previous_bookings.disabled_dates.select { |d| d >= @booking.start_date && d <= @booking.end_date}.uniq
    @days = time_difference(@booking.start_date, @booking.end_date) - disabled_dates.size

    dates = (@booking.start_date.to_date..@booking.end_date.to_date).to_a
    available_dates = dates.select { |d| !previous_bookings.where.not(id: @booking.id).disabled_dates.include?(d) }.uniq
    available_dates = available_dates.map do |d|
      {
        start: d.iso8601,
        allDay: true,
        rendering: 'background'
      }
    end

    @booking_pricing = @booking.listing.pricing.paper_trail.version_at(@booking.created_at)

    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: available_dates }
    end

  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
    @booking.build_message
    gon.disabled_dates = @listing.bookings.disabled_dates
  end

  def create
    @listing = Listing.find(params[:booking][:listing_id])
    @booking = Booking.new(updating_message_attributes)

    if current_user.listings.include?(@listing)
      flash.now[:error] = "Vous ne pouvez pas réserver un vélo qui vous appartient déjà."
      render 'new'
    end and return

    if checking_available_dates.present?
      flash.now[:error] = "Vous avez déjà loué un vélo aux dates suivantes : #{checking_available_dates}"
      render 'new'
    end and return

    if @booking.save
      flash[:success] = "Votre réservation a été enregistrée avec succès."
			redirect_to web_listing_path(@booking.listing)
    else
      flash.now[:error] = @booking.errors.values
      render 'new'
    end
  end

  def calculate
    render json: @total_price
  end

  def resume
    if request.xhr?
			render partial: 'resume'
		end
  end

  def accept
    booking = Booking.find(params[:booking_id])
    booking.status = "accepted"
    if booking.save
      @conversation = booking.message.conversation
      redirect_to conversation_path(@conversation)
    else
      render "conversations/show"
    end
  end

  def refuse
    booking = Booking.find(params[:booking_id])
    booking.status = "refused"
    if booking.save
      @conversation = booking.message.conversation
      redirect_to conversation_path(@conversation)
    else
      render "conversations/show"
    end
  end

  private

  def booking_params
		params.require(:booking).permit(:listing_id, :start_date, :end_date, :total_price,
      message_attributes: [:body, :conversation_id, :user_id]).merge(user_id: current_user.id)
	end

  def calculate_booking_data
    start_date = Time.parse(params[:start_date]) rescue nil
    end_date = Time.parse(params[:end_date]) rescue nil
    @listing = Listing.find(params[:listing_id])

    if start_date.present? && end_date.present?
      disabled_dates = @listing.bookings.disabled_dates.select { |d| d >= start_date && d <= end_date}.uniq
      @days = time_difference(start_date, end_date) - disabled_dates.size
      base_price = @days * @listing.pricing.base_price
      discount = 0
      if @days >= 7 && @days < 28
        discount = base_price * (@listing.pricing.average_weekly / 100)
      elsif @days >= 28
        discount = base_price * (@listing.pricing.average_monthly / 100)
      end
      @total_price = base_price - discount + @listing.pricing.maintenance_fee
    end
  end

  def checking_available_dates
    start_date = Time.parse(booking_params[:start_date])
    end_date = Time.parse(booking_params[:end_date])
    dates = (start_date.to_date..end_date.to_date).to_a
    disabled_dates = dates.select { |d| current_user.bookings.disabled_dates.include?(d) }.uniq
    return disabled_dates
  end

  def updating_message_attributes
    conversations = Conversation.all.where('borrower_id = ? and lender_id = ?', current_user.id, @listing.user.id)
    if conversations.present?
      conversation = conversations.last
    else
      conversation = Conversation.create(borrower_id: current_user.id, lender_id: @listing.user.id)
    end

    params_updated = booking_params
    if params_updated[:message_attributes].present?
      params_updated[:message_attributes][:conversation_id] = conversation.id
      params_updated[:message_attributes][:user_id] = current_user.id
    end
    return params_updated
  end

end
