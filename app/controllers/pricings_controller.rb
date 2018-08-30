class PricingsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_listing

	def new
		@pricing = Pricing.new
	end

	def create
		@pricing = Pricing.new(pricing_params)
		if @pricing.save
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to new_listing_availability_path(@listing)
		else
			flash.now[:error] = @pricing.errors.values
			render 'new'
		end
	end

	def edit
		@pricing = Pricing.find(params[:id])
	end

	def update
		@pricing = Pricing.find(params[:id])
		if @pricing.update_attributes(pricing_params)
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to edit_listing_pricing_path(listing_id: @listing.id, id: @pricing.id)
		else
			flash.now[:error] = @pricing.errors.values
			render 'edit'
		end
	end

	def daily_price
		render 'daily_price'
	end

	private

	def pricing_params
		params.require(:pricing).permit(:base_price, :average_weekly, :average_monthly,
			:currency, :weekend_pricing, :security_deposit, :maintenance_fee).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end
end
