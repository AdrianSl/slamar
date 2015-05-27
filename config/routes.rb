Rails.application.routes.draw do
  get 'general_expenses/new'

  devise_for :users
  root 'dashboard#index'
end
