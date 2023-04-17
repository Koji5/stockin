Rails.application.routes.draw do
  root 'purchase_records#index'
  resources :products
  resources :suppliers
  resources :purchase_records
  get '/purchase_records/get_suppliers', to: 'purchase_records#get_suppliers'
end
