class HomeController < ApplicationController
  def index
    @cities = Location.all.map(&:locality).uniq
  end
end
