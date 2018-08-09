Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to:'home#index'
  get 'dashboard', to: 'dashboard#index'

  resources :listings do
  	resources :pricings
  	resources :availabilities
  	get 'edit_status'
  	patch 'update_status'
    resources :bookings, only: [:new, :create]
  end

  get 'search', to: 'listings#search'
  namespace :web do
    resources :listings, only: [:index, :show]
  end

  get '/bookings/resume', to: 'bookings#resume'
  get '/bookings/calculate', to: 'bookings#calculate'
  get '/bookings/current', to: 'bookings#current_bookings'
  get '/bookings/past', to: 'bookings#past_bookings'
  get '/bookings/upcoming', to: 'bookings#upcoming_bookings'

  resources :bookings, only: [:show, :update]
  resources :conversations
  resources :messages
end
