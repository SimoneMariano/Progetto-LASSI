Rails.application.routes.draw do
  resources :bulletins
  
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
  
  get 'athenaeum' => 'athenaeum#index', :as => :athenaeum

  resources :reservations
  get "reservation", to: "reservation#index"

  resources :seats
  get "seat", to: "seats#index"

  resources :view_reservations
  get 'view_reservation', to: "view_reservations#index"




  get 'home' => 'home#index', :as => :home

  get 'login' => 'login#index', :as => :login


  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'

  get 'profile', to: 'users#index', :as => :profile
  get 'profile/edit', to: 'users#edit', :as => :profile_edit
  resources :users

  get 'books/addToFavorites/:id', to: 'books#addToFavorites', :as => :addToFavorites
  get 'books/removeFromFavorites/:id', to: 'books#removeFromFavorites', :as => :removeFromFavorites


  get 'ticket/new', to: 'ticket_mailer#new', :as => :new_mail
  post 'ticket/send', to: 'ticket_mailer#send_email', :as => :send_mail


 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
