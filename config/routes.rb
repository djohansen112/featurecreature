Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :posts do
    resource :cover_image, only: [:destroy], module: :posts
    resources :comments
  end

  get 'cat/:name', to: 'posts#showcategory', as: 'category'

  get 'categories', to: 'posts#categories', as: 'categories'
  get 'about', to: 'posts#about', as: 'about'
  get 'contact', to: 'posts#contact', as: 'contact'
  # Defines the root path route ("/")
  root to: 'posts#index'
end
