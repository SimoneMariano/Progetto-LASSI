Rails.application.routes.draw do
  
  resources :book_rentals
  resources :books
  resources :library
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
