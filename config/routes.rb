Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    root 'users#home'

    resources :users do
      resources :things
      resources :categories
    end

    post '/login', to: 'sessions#login', as: :login
    delete '/logout', to: 'sessions#logout', as: :logout
end
