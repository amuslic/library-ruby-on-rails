Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :users, only: [:index, :show]

  resources :authors, only: [:index]
  resources :loans, only: [:index, :create] do
    collection do
      get 'users/:user_id', to: 'loans#index_by_user', as: 'user_loans'
    end
  end

  resources :books, only: [:index, :show] do
    collection do
      get 'out-of-stock', to: 'books#index_out_of_stock'
      get 'search', to: 'books#search'
    end
  end

  post '/login', to: 'authorization#login'
end
