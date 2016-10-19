Rails.application.routes.draw do
  namespace :api do
    post 'upload', to: 'uploads#reciever'
  end

  resources :recipients

  root "home#index"
end