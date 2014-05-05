FacebookCard::Application.routes.draw do
  match 'auth/:provider/callback', via: [:get, :post], to: 'sessions#create'
  match 'auth/failure', via: [:get, :post], to: redirect('/')
  match 'signout', to: 'sessions#destroy', via: [:get, :post], as: 'signout'

  resources :users do
    resources :cards
  end

  root to: 'users#index'


end
