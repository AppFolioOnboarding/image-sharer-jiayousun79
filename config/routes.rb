Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  resources :feedbacks, only: [:new]

  resources :images, only: %i[index new create show destroy]

  namespace :api do
    resource :feedbacks, only: [:create]
  end
end
