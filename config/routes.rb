Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index' 

  resources :items do
    resources :orders
  end

  resources :items, only: [:index, :new, :create] do
    resource :likes, only: [:create, :destroy]
  end
end
