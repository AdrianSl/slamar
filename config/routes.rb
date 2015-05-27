Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  resources :general_expenses, only: [:new, :create]
end
