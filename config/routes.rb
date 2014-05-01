FacebookCard::Application.routes.draw do
  match 'auth/:provider/callback', via: [:get, :post], to: 'sessions#create'
  match 'auth/failure', via: [:get, :post], to: redirect('/')
  match 'signout', to: 'sessions#destroy', via: [:get, :post], as: 'signout'

  resources :cards

  root to: 'cards#index'
end
