Rails.application.routes.draw do
  get 'homes/index'
  devise_for :users
  resources :loans

  root "loans#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end