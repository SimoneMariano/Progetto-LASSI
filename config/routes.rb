Rails.application.routes.draw do

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

  get 'athenaeum' => 'athenaeum#index', :as => :athenaeum

  resources :reservations
  get "reservation", to: "reservation#index"

  resources :seats
  get "seat", to: "seats#index"

  resources :view_reservations
  get 'view_reservation', to: "view_reservations#index"




  get 'home' => 'home#index', :as => :home
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
