Rails.application.routes.draw do
  namespace :api, constraints:{ format: 'json' } do
    namespace :v1 do
      get 'spots', to: 'spots#index'

      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
    end
  end
end
