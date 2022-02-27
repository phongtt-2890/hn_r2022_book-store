Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#home"
    resources :users, only: %i(show new create edit)
    resources :books, only: %i(show index)
    resource :carts, only: %i(show update destroy)
    get "/orders", to: "carts#index"
    resources :order_details, only: %i(create update destroy)

    namespace :admin do
      root "dashboards#home"
      resources :orders, only: %i(index update destroy)
      resources :books
    end

    devise_for :users, path: "auth"
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      get "/signup", to: "devise/registrations#new"
      delete "/logout", to: "devise/sessions#destroy"
    end
    get "/search_books", to: "home_pages#home"
  end
end
