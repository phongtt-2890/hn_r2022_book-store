Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: %i(show new create edit)
    resources :books, only: %i(show index)
    resource :carts
    get "/orders", to: "carts#index"
    resources :order_details, only: %i(create update destroy)

    namespace :admin do
      root "dashboards#home"
    end
  end
end
