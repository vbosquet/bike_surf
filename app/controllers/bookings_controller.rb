class BookingsController < ApplicationController
  include ApplicationHelper
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
    when "current"
      @bookings = current_user.bookings.current
      @title = "Locations en cours"
    end

    if request.xhr?
      render partial: 'bookings'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    listing = @booking.listing
    previous_bookings = listing.bookings.where("created_at < ?", @booking.created_at)
    disabled_dates = previous_bookings.dates.select { |d| d >= @booking.start_date && d <= @booking.end_date}.uniq
    @days = time_difference(@booking.start_date, @booking.end_date) - disabled_dates.size
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
    gon.disabled_dates = @listing.bookings.dates
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
    start_date = Time.parse(params[:start_date]) rescue nil
    end_date = Time.parse(params[:end_date]) rescue nil
    @listing = Listing.find(params[:listing_id])

    if start_date.present? && end_date.present?
      disabled_dates = @listing.bookings.dates.select { |d| d >= start_date && d <= end_date}.uniq
      @days = time_difference(start_date, end_date) - disabled_dates.size
      @total_price = @days * @listing.pricing.base_price
    end
  end

end
