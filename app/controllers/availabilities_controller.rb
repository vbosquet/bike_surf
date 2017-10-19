class AvailabilitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :find_listing

	def new
		@availability = Availability.new
	end

	def create
		availability = Availability.new(availability_params)
		if availability.save
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to listing_edit_status_path(@listing)
		else
		end
	end

	def edit
		@availability = Availability.find(params[:id])
	end

	def update
		availability = Availability.find(params[:id])
		if availability.update_attributes(availability_params)
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to edit_listing_availability_path(listing_id: @listing.id, id: availability.id)
		else
		end
	end

	private

	def availability_params
		params.require(:availability).permit(:advance_notice, :minimum_rental, :maximum_rental, 
			:dropoff_time, :pickup_time).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end
end
