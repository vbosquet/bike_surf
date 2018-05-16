class Web::ListingsController < ApplicationController

  def index
    city = params[:city]
    @listings = Listing.joins(:location).where("listings.listed = ? and locations.locality = ?", true, city).distinct
  end

  def show
		@listing = Listing.find(params[:id])
		gon.latitude = @listing.location.latitude
		gon.longitude = @listing.location.longitude
	end

end
