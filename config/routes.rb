Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'spots', to: 'spots#index'
    end
  end
end
