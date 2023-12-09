Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index]
  get 'users/search', to: 'users#search'
  # Defines the root path route ("/")
  # root "articles#index"
end
