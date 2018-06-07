Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to:'home#index'
  get "dashboard", to: 'dashboard#index'
  resources :listings do
  	resources :pricings
  	resources :availabilities
  	get 'edit_status'
  	patch 'update_status'
  end
  get 'search', to: 'listings#search'
  namespace :web do
    resources :listings, only: [:index, :show]
  end
  get '/bookings/resume', to: "bookings#resume"
  get '/bookings/calculate', to: "bookings#calculate"
  resources :bookings
end
