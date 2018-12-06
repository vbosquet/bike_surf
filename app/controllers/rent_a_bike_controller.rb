class RentABikeController < ApplicationController
  include Wicked::Wizard
	steps :add_description, :add_pricing, :add_availability

  def show
    case step
    when :add_description
      session[:listing].nil? ? @listing = Listing.new : @listing = Listing.new(session[:listing])
      session[:bike].nil? ? @listing.build_bike : @listing.build_bike(session[:bike])
      session[:location].nil? ? @listing.build_location : @listing.build_location(session[:location])
    when :add_pricing
      @listing = Listing.new(session[:listing])
      session[:pricing].nil? ? @listing.build_pricing : @listing.build_pricing(session[:pricing])
    when :add_availability
      @listing = Listing.new(session[:listing])
      session[:availability].nil? ? @listing.build_availability : @listing.build_availability(session[:availability])
    end
    render_wizard
  end

  def update
    case step
    when :add_description
      @listing = Listing.new(listing_params)
      @bike = @listing.build_bike(listing_params[:bike_attributes])
      @location = @listing.build_location(listing_params[:location_attributes])

      if params[:commit] == "Annuler"
        session[:listing] = nil
        session[:bike] = nil
        session[:location] = nil
  			redirect_to listings_path
      else
        session[:listing] = @listing.attributes
        session[:bike] = @bike.attributes
        session[:location] = @location.attributes
        redirect_to next_wizard_path
  		end
    when :add_pricing
      @listing = Listing.new(session[:listing])
      @pricing = @listing.build_pricing(listing_params[:pricing_attributes])

      if params[:commit] == "Annuler"
  			redirect_to previous_wizard_path
      else
        session[:pricing] = @pricing.attributes
        redirect_to next_wizard_path
  		end
    when :add_availability
      if params[:commit] == "Annuler"
  			redirect_to previous_wizard_path
      else
        @listing = Listing.new(session[:listing])
        @listing.save
        @listing.create_bike(session[:bike])
        @listing.create_location(session[:location])
        @listing.create_pricing(session[:pricing])
        @listing.create_availability(listing_params[:availability_attributes])
        redirect_to listing_path(@listing)
  		end
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
