Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts
      get 'spots', to: 'spots#index'
    end
  end
end
