class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_listing, :find_bike

  def index
    @photos = @bike.photos
    @photo = Photo.new
  end

  def new
    @photo = Photo.new
  end

  def create
    unless params[:photo].present?
      redirect_to listing_bike_photos_path(listing_id: @listing, bike_id: @listing.bike)
    end and return

    @photo = Photo.new(photo_params)
    if @photo.save
			flash[:success] = "Photo ajoutée avec succès"
			redirect_to listing_bike_photos_path(listing_id: @listing, bike_id: @listing.bike)
		else
			flash[:error] = @photo.errors.values
      redirect_to listing_bike_photos_path(listing_id: @listing, bike_id: @listing.bike)
		end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo supprimée avec succès"
			redirect_to listing_bike_photos_path(listing_id: @listing, bike_id: @listing.bike)
    end
  end

  private

	def photo_params
		params.require(:photo).permit(:attachment).merge(bike_id: @bike.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end

  def find_bike
    @bike = Bike.find(params[:bike_id])
  end

end
