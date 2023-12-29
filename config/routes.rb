Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users
  resources :authors, only: [:index]
  #books
  get '/books/out-of-stock', to: 'books#index_out_of_stock'
  get '/books/search', to: 'books#search'
  get '/books/:id', to: 'books#show'
  get '/books', to: 'books#index'

  #login
  post '/login', to: 'authorization#login'


  resources :loans, only: [:index, :create]
    get 'loans/users/:user_id', to: 'loans#index_by_user', as: 'user_loans'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
