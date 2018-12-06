Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to:'home#index'
  get 'dashboard', to: 'dashboard#index'

  resources :listings do
  	resources :pricings, except: [:edit] do
      get 'daily_price'
      get 'discounts'
      get 'extra_fees'
      get 'currency'
    end
  	resources :availabilities, except: [:edit] do
      get 'checkin_setting'
      get 'rental_length'
      get 'reservation_preferences'
    end
    resources :bikes, except: [:edit] do
      get 'equipments'
      get 'size'
      resources :photos
    end
    get 'edit/description', to: 'listings#edit_description'
    get 'edit/location', to: 'listings#edit_location'
    get 'edit/status', to: 'listings#edit_status'
    resources :bookings, only: [:create, :index]
    get 'bookings/resume', to: 'bookings#resume'
    get 'bookings/payment', to: 'bookings#payment'
    resources :messages, only: [:new]
  end

  get 'search', to: 'listings#search'
  namespace :web do
    resources :listings, only: [:index, :show]
  end

  get '/rentals/current', to: 'bookings#current_rentals'
  get '/rentals/past', to: 'bookings#past_rentals'
  get '/rentals/upcoming', to: 'bookings#upcoming_rentals'
  get '/pricings/calculate_average', to: 'pricings#calculate_average'

  resources :bookings, only: [:show, :update]
  resources :conversations
  resources :messages, except: [:new]
  resources :rent_a_bike
end
