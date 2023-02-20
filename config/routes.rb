Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "feeds#index"

  scope path: "/moderation", module: 'moderation', as: :moderation do
    resources :websites
  end
end
