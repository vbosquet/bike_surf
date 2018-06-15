class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :calculate_booking_data, only: [:calculate, :resume]

  def index
    case params[:type]
    when "upcoming"
      @bookings = current_user.bookings.upcoming
      @title = "Locations à venir"
    when "past"
      @bookings = current_user.bookings.past
      @title = "Anciennes locations"
    end

    if request.xhr?
      render partial: 'bookings'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @days = TimeDifference.between(@booking.start_date, @booking.end_date).in_days
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @listing = Listing.find(params[:booking][:listing_id])

    if current_user.listings.include?(@listing)
      flash.now[:error] = "Vous ne pouvez pas réserver un vélo qui vous appartient déjà."
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

  private

  def booking_params
		params.require(:booking).permit(:listing_id, :start_date, :end_date, :total_price).merge(user_id: current_user.id)
	end

  def calculate_booking_data
    @listing = Listing.find(params[:listing_id])
    @days = TimeDifference.between(Time.parse(params[:start_date]), Time.parse(params[:end_date])).in_days
    @total_price = @days * @listing.pricing.base_price
  end

end
