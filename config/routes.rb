Rails.application.routes.draw do
  resources :categories
  resources :secondhands
  
  resources :book_rentals
  resources :books
  resources :library
  resources :book_scraper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
