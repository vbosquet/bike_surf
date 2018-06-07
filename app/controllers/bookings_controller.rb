class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :calculate_booking_data, only: [:calculate, :resume]

  def index
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    booking = Booking.new(booking_params)
    if booking.save
      flash[:success] = "Votre réservation a été enregistrée avec succès."
			redirect_to web_listing_path(booking.listing)
    else
      flash[:error] = "Une erreur s'est produite veuillez réessayer"
    end
  end

  def calculate
    render json: @total_price
  end

  def resume
    if request.xhr?
			render partial: 'resume', locals: {listing: @listing, days: @days, total_price: @total_price}
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
