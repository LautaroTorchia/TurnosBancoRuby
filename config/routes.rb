Rails.application.routes.draw do
  resources :branches do
    resources :schedules
  end
  root 'home#index'
  get '/home/about', to: 'home#about', as: 'about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
