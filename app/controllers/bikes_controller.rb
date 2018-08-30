class BikesController < ApplicationController
  before_action :authenticate_user!
	before_action :find_listing

  def new
		@bike = Bike.new
	end

	def create
		@bike = Bike.new(bike_params)
		if @bike.save
			flash[:success] = "Informations enregistrées avec succès"
		else
			flash.now[:error] = @bike.errors.values
			render 'new'
		end
	end

  private

	def bike_params
		params.require(:pricing).permit(:size, :lights, :hasBackPedalBrake,
			:helmet, :basket, :fonts, :photo).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end

end
