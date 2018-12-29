Rails.application.routes.draw do
  
  get 'homes/index'
  get '/thankyou', to: "feedbacks#thankyou"
  devise_for :users, :skip => [:registration]

  resources :loans
  resources :feedbacks

  resources :loans do
  	collection {post :import}
  end

  authenticate :user do
  	resources :feedbacks, only: [:index, :edit, :update, :destroy]
  end
  root "loans#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
