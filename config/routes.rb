Offers::Application.routes.draw do
  resources :offers_requests, only: [:new, :create] do
    get :test, on: :collection
  end
  root to: 'offers_requests#new'
end
