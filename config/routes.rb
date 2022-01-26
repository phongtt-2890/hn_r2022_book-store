Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#home"
  end
end
