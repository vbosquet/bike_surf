class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :email, :phone_number])
  end
end
