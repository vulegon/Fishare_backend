Rails.application.routes.draw do
  namespace :api, constraints:{ format: 'json' } do
    namespace :v1 do
      resources :spots, only: [:index, :create]

      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
    end
  end
end
