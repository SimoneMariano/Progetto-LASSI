Rails.application.routes.draw do
  
  devise_for :users, :controllers => {
    :sessions => "users/sessions", 
    :registrations => "users/registrations",
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
  


  root "home#index"

  resources :courses
  resources :authors
  resources :categories
  resources :secondhands
  
  resources :book_rentals
  resources :books 
  get 'library' => 'library#index', :as => :library
  get "/book_scraper/:ISBN" => "book_scraper#index", :as => :scraper

  get "filter", to: "books#filter"
  get "filter_secondhands", to: "secondhands#filter"
  get "display_to_approve", to: "secondhands#display_to_approve"
  get "approved", to: "secondhands#approved"
  get "/approve/:id", to: "secondhands#approve", :as => :approve

  get "display_my_adv", to: "secondhands#display_my_adv"

  get 'home' => 'home#index', :as => :home

  get 'login' => 'login#index', :as => :login


  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'

  #get "/calendar/new", to: 'example#new', :as => :new_calendar_event
  #get "/calendar/create", to: 'example#create', :as => :create_calendar_event



 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
