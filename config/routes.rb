Rails.application.routes.draw do
  root 'purchase_records#index'
  resources :products
  resources :suppliers
  resources :purchase_records do
    collection do
      get 'get_suppliers'
      get 'search'
    end
  end
end