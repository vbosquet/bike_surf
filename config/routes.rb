Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to:'home#index'
  get 'dashboard', to: 'dashboard#index'

  resources :listings, except: [:show] do
  	resources :pricings do
      get 'daily_price'
    end
  	resources :availabilities
    resources :bikes
    get 'preview'
    get 'details'
    get 'details/description', to: 'listings#edit_description'
    get 'details/location', to: 'listings#edit_location'
    get 'details/status', to: 'listings#edit_status'
    get 'details/bike', to: 'listings#edit_bike'
    resources :bookings, only: [:new, :create, :index]
  end

  get 'search', to: 'listings#search'
  namespace :web do
    resources :listings, only: [:index, :show]
  end

  get '/bookings/resume', to: 'bookings#resume'
  get '/bookings/calculate', to: 'bookings#calculate'
  get '/rentals/current', to: 'bookings#current_rentals'
  get '/rentals/past', to: 'bookings#past_rentals'
  get '/rentals/upcoming', to: 'bookings#upcoming_rentals'

  resources :bookings, only: [:show, :update]
  resources :conversations
  resources :messages
end
