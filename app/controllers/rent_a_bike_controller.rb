class RentABikeController < ApplicationController
  include Wicked::Wizard
	steps :add_description, :add_pricings, :add_availabilities

  def show
    case step
    when :add_description
      @listing = Listing.new
      @listing.build_bike
      @listing.build_location
      session[:listing] = nil
    when :add_pricings
      @listing = Listing.new(session[:listing])
      @listing.build_pricing
    when :add_availabilities
      @listing = Listing.new(session[:listing])
      @listing.build_availability
    end
    render_wizard
  end

  def update
    case step
    when :add_description
      @listing = Listing.new(listing_params)
      @bike = @listing.build_bike(listing_params[:bike_attributes])
      @location = @listing.build_location(listing_params[:location_attributes])
      session[:listing] = @listing.attributes
      session[:bike] = @bike.attributes
      session[:location] = @location.attributes
      redirect_to next_wizard_path
    when :add_pricings
      @listing = Listing.new(session[:listing])
      @pricing = @listing.build_pricing(listing_params[:pricing_attributes])
      session[:pricing] = @pricing.attributes
      redirect_to next_wizard_path
    when :add_availabilities
      @listing = Listing.new(session[:listing])
      @listing.save
      @listing.create_bike(session[:bike])
      @listing.create_location(session[:location])
      @listing.create_pricing(session[:pricing])
      @listing.create_availability(listing_params[:availability_attributes])
      redirect_to listing_path(@listing)
    end
  end

  private

  def finish_wizard_path
    listing_path(@listing)
  end

  def listing_params
		params.require(:listing).permit(:title, :description, :listed,
			bike_attributes: [:id, :lights, :size, :listing_id, :helmet, :fonts, :basket, :hasBackPedalBrake, :child_seat],
			location_attributes: [:id, :street_number, :route, :locality, :postal_code, :country_code],
      pricing_attributes: [:id, :base_price, :weekly_discount, :monthly_discount, :currency, :weekend_pricing,
        :security_deposit, :maintenance_fee],
      availability_attributes: [:id, :advance_notice, :minimum_rental, :maximum_rental,
  			:dropoff_time, :pickup_time, :deadline]).merge(user_id: current_user.id)
	end

end
