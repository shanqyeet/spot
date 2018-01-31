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
    get "/auth/:provider/callback", to: "sessions#create_from_omniauth"
    post "/addupvote", to: "thing_upvotes#create", as: :add_upvote
    delete "/removeupvote", to: "thing_upvotes#destroy", as: :remove_upvote
    post "/adddownvote", to: "thing_downvotes#create", as: :add_downvote
    delete "/removedownvote", to: "thing_downvotes#destroy", as: :remove_downvote
end
