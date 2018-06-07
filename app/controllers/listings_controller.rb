class ListingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@listings = current_user.listings
	end

	def show
		@listing = Listing.find(params[:id])
		gon.latitude = @listing.location.latitude
		gon.longitude = @listing.location.longitude
	end

	def new
		@listing = Listing.new
		unless @listing.bike.present?
			@listing.build_bike
		end
		unless @listing.location.present?
			@listing.build_location
		end
	end

	def create
		@listing = Listing.new(listing_params)
		if @listing.save
			flash[:success] = "Annonce créée avec succès"
			redirect_to new_listing_pricing_path(@listing)
		else
			flash.now[:error] = @listing.errors.values
			render 'new'
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update_attributes(listing_params)
			flash[:success] = "Annonce modifiée avec succès"
			redirect_to edit_listing_path(@listing)
		else
			flash.now[:error] = @listing.errors.values
			render 'edit'
		end
	end

	def edit_status
		@listing = Listing.find(params[:listing_id])
	end

	def update_status
		listing = Listing.find(params[:listing_id])
		if listing.update_attributes(listed: params[:listing][:listed])
			if listing.listed?
				@listed = "publiée"
			else
				@listed = "désactivée"
			end
			flash[:success] = "Annonce #{@listed} avec succès"
			redirect_to listing_edit_status_path(listing)
		else
			flash[:error] = "Une erreur s'est produite veuillez réessayer"
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
		params.require(:listing).permit(:title, :description,
			bike_attributes: [:id, :lights, :size, :photo, :listing_id],
			location_attributes: [:id, :street_number, :route, :locality, :postal_code, :country_code]).merge(user_id: current_user.id)
	end
end
