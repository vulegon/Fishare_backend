Rails.application.routes.draw do
  namespace :api, constraints:{ format: 'json' } do
    namespace :v1 do
      resources :spots, only: [:index, :create, :show]
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions',
        passwords: 'api/v1/auth/passwords',
        confirmations: 'api/v1/auth/confirmations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
end
