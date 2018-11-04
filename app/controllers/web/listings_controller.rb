class Web::ListingsController < ApplicationController

  def index
    @city = params[:city]
    @listings = Listing.joins(:location).where("listings.listed = ? and locations.locality = ?", true, @city).distinct
  end

  def show
		@listing = Listing.find(params[:id])
    gon.disabled_dates = @listing.bookings.dates
    @prev_url =  web_listing_path(@listing)
		# gon.latitude = @listing.location.latitude
		# gon.longitude = @listing.location.longitude
    @full_sanitizer = Rails::Html::FullSanitizer.new
	end

end
