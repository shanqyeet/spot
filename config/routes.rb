Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    root 'users#home'

    resources :users do
      resources :things
      resources :categories
      resources :shopping_items
    end

    get '/signup', to: 'users#signup', as: :signup
    get '/signin', to: 'users#signin', as: :signin
    post '/login', to: 'sessions#login', as: :login
    delete '/logout', to: 'sessions#logout', as: :logout
    get "/auth/:provider/callback", to: "sessions#create_from_omniauth"

    # Votes routes
    post "/addupvote", to: "thing_upvotes#create", as: :add_upvote
    delete "/removeupvote", to: "thing_upvotes#destroy", as: :remove_upvote
    post "/adddownvote", to: "thing_downvotes#create", as: :add_downvote
    delete "/removedownvote", to: "thing_downvotes#destroy", as: :remove_downvote

    # Shoping List routes
    post "users/:user_id/shopping_items/:id/check", to: "shopping_items#check", as: :check_item
    post "users/:user_id/shopping_items/:id/uncheck", to: "shopping_items#uncheck", as: :uncheck_item

    # Search routes
    get "/search", to: "things#search", as: :search
end
