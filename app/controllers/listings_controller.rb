class ListingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_full_sanitizer, only: [:show, :edit]

	def index
		@listings = current_user.listings
	end

	def show
		@listing = Listing.find(params[:id])
		gon.disabled_dates = @listing.bookings.dates
		# gon.latitude = @listing.location.latitude
		# gon.longitude = @listing.location.longitude
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def edit_description
		@listing = Listing.find(params[:listing_id])
		render "listings/edit/edit_description"
	end

	def edit_location
		@listing = Listing.find(params[:listing_id])
		render "listings/edit/edit_location"
	end

	def edit_status
		@listing = Listing.find(params[:listing_id])
		render "listings/edit/edit_status"
	end

	def update
		@listing = Listing.find(params[:id])

		if params[:commit] == "Annuler"
			redirect_to edit_listing_path(@listing)
			return nil
		end

		if @listing.update_attributes(listing_params)
			flash[:success] = "Annonce modifiée avec succès"
			redirect_to edit_listing_path(@listing)
		else
			flash[:error] = @listing.errors.values
			redirect_to :back
		end
	end

	def search
		city = params[:city]
		if city.present?
			@listings = Listing.joins(:location).where("locations.locality like ?", "%#{city}%").where("listings.listed = ?", true)
		else
			@listings = Listing.where("listings.listed = ?", true)
		end
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :description, :listed,
			bike_attributes: [:id, :lights, :size, :listing_id, :helmet, :fonts, :basket, :hasBackPedalBrake, :child_seat],
			location_attributes: [:id, :street_number, :route, :locality, :postal_code, :country_code]).merge(user_id: current_user.id)
	end

	def set_full_sanitizer
    @full_sanitizer = Rails::Html::FullSanitizer.new
  end
end
