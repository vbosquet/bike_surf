class PricingsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_listing, except: [:calculate_average]

	def update
		@pricing = Pricing.find(params[:id])

		if params[:commit] == "Annuler"
			redirect_to edit_listing_path(@listing)
			return nil
		end

		if @pricing.update_attributes(pricing_params)
			flash[:success] = "Informations enregistrées avec succès"
			redirect_to edit_listing_path(@listing)
		else
			flash.now[:error] = @pricing.errors.values
			redirect_to :back
		end
	end

	def daily_price
		@pricing = Pricing.find(params[:pricing_id])
		render 'pricings/edit/daily_price'
	end

	def discounts
		@pricing = Pricing.find(params[:pricing_id])
		render 'pricings/edit/discounts'
	end

	def extra_fees
		@pricing = Pricing.find(params[:pricing_id])
		render 'pricings/edit/extra_fees'
	end

	def currency
		@pricing = Pricing.find(params[:pricing_id])
		render 'pricings/edit/currency'
	end

	def calculate_average
		discount = params[:discount].to_i
		base_price = params[:base_price].to_i
		type = params[:average_type]

		price = type == "weekly" ? base_price * 7 : base_price * 28
		average = price - (price * (discount / 100.0))

		render json: average.round
	end

	private

	def pricing_params
		params.require(:pricing).permit(:base_price, :weekly_discount, :monthly_discount,
			:currency, :weekend_pricing, :security_deposit, :maintenance_fee).merge(listing_id: @listing.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end
end
