Rails.application.routes.draw do

  root "home#index"

  resources :courses
  resources :authors
  resources :categories
  resources :secondhands
  
  resources :book_rentals
  resources :books 
  get 'library' => 'library#index', :as => :library
  resources :book_scraper

  get "filter", to: "books#filter"
  get "filter_secondhands", to: "secondhands#filter"

  get 'home' => 'home#index', :as => :home
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
