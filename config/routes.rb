Rails.application.routes.draw do

  get 'homes/index'
  get '/thankyou', to: "feedbacks#thankyou"
  get '/thank_you', to: "housing_rentals#thank_you"

  devise_for :users, skip: :registrations
  resources :housing_rentals
  resources :loans
  resources :feedbacks

  resources :loans do
    collection { post :import }
  end

  authenticate :user do
    resources :feedbacks, only: [:index, :edit, :update, :destroy]
  end
  root "loans#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
