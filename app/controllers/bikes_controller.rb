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

  def equipments
    @bike = Bike.find(params[:bike_id])
    render 'bikes/edit/equipments'
  end

  def update
    @bike = Bike.find(params[:id])

		if params[:commit] == "Annuler"
			redirect_to listing_details_path(@listing)
			return nil
		end

		if @bike.update_attributes(bike_params)
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to listing_details_path(@listing)
		else
			flash.now[:error] = @bike.errors.values
			redirect_to :back
		end
  end

  private

	def bike_params
		params.require(:pricing).permit(:size, :lights, :hasBackPedalBrake,
			:helmet, :basket, :fonts, :child_seat).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end

end
