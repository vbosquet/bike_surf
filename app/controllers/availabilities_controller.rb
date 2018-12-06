class AvailabilitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :find_listing

	def update
		@availability = Availability.find(params[:id])

		if params[:commit] == "Annuler"
			redirect_to edit_listing_path(@listing)
			return nil
		end

		if @availability.update_attributes(params_updated)
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to edit_listing_path(@listing)
		else
			flash.now[:error] = @availability.errors.values
			redirect_to :back
		end
	end

	def checkin_setting
		@availability = Availability.find(params[:availability_id])
		render 'availabilities/edit/checkin_setting'
	end

	def rental_length
		@availability = Availability.find(params[:availability_id])
		render 'availabilities/edit/rental_length'
	end

	def reservation_preferences
		@availability = Availability.find(params[:availability_id])
		render 'availabilities/edit/reservation_preferences'
	end

	private

	def availability_params
		params.require(:availability).permit(:advance_notice, :minimum_rental, :maximum_rental,
			:dropoff_time, :pickup_time, :deadline).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end

	def params_updated
		params_updated = availability_params
		if params_updated[:advance_notice] != Availability.advance_notices.keys.first
			params_updated[:deadline] = "00:00"
		end
		return params_updated
	end
end
