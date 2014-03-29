Offers::Application.routes.draw do
  resources :offers_requests, only: [:new, :create]
  root to: 'offers_requests#new'
end
