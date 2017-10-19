class ListingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@listings = current_user.listings
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@listing = Listing.new
		Rails.logger.debug("LISTING: #{@listing.persisted?.inspect}")
		unless @listing.bike.present?
			@listing.build_bike
		end
		unless @listing.location.present?
			@listing.build_location
		end
	end

	def create
		listing = Listing.new(listing_params)
		if listing.save
			flash[:success] = "Annonce créée avec succès"
			redirect_to new_listing_pricing_path(listing)
		else
			#Rails.logger.debug("ERROR: #{listing.errors.messages.inspect}")
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		listing = Listing.find(params[:id])
		if listing.update_attributes(listing_params)
			flash[:success] = "Annonce modifiée avec succès"
			redirect_to edit_listing_path(listing)
		else
			flash[:error] = "Une erreur s'est produite veuillez réessayer"
		end
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :description, :listed, 
			bike_attributes: [:id, :lights, :size, :photo, :listing_id],
			location_attributes: [:id, :street_number, :route, :locality, :postal_code]).merge(user_id: current_user.id)
	end
end
