class HomeController < ApplicationController
  def index
    @listings = Listing.where("listed = ?", true)
  end
end
