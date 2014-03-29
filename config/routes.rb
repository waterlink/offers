Offers::Application.routes.draw do
  resources :offers_requests, only: :index
  root to: 'offers_requests#index'
end
