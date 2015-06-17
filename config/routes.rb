Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  resources :general_expenses, only: [:new, :create]
  resources :general_expenses do
    get :autocomplete_name, on: :collection
  end
  resources :brand_shops, only: [:new, :create]
end
