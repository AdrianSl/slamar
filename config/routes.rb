Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  resources :dashboard, only: [:create, :show, :index], constraints: { id: /(\d{4})-(\d{2})-(\d{2})/ }
  resources :general_expenses do
    get :autocomplete_name, on: :collection
  end
  resources :brand_shops, except: [:show]
  resources :drivers, only: [:new, :create]
  resources :truck_routes, only: [:new, :create]
  resources :external_shops, only: [:new, :create]
  resources :incomes, only: [:new, :create] do
    collection do
      put :update_multiple
    end
  end
end
