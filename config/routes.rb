Rails.application.routes.draw do

  devise_for :users , controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :users
  scope :users do
    get 'users/new_admin', to: 'users#admin_new', :as => 'new_admin'
  end
  
  resources :branches do
    resources :schedules
  end

  root 'home#index'
  get '/home/about', to: 'home#about', as: 'about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
