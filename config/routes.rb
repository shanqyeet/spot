Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    root 'users#home'

    resources :user do
      resources :things
      resources :categories
    end
end
