Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  resources :dashboard, only: [:create, :show, :index], constraints: { id: /(\d{4})-(\d{2})-(\d{2})/ }
  resources :general_expenses, except: [:show] do
    get :autocomplete_name, on: :collection
  end
  resources :brand_shops, except: [:show]
  resources :drivers, except: [:show]
  resources :truck_routes, except: [:show]
  resources :external_shops, except: [:show]
  resources :incomes, except: [:show] do
    collection do
      put :update_multiple
    end
  end
end
