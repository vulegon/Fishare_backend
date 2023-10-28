Rails.application.routes.draw do
  namespace :api, constraints: { format: "json" } do
    namespace :v1 do
      resources :spots
      mount_devise_token_auth_for "User", at: "auth", skip: [:omniauth_callbacks], controllers: {
                registrations: "api/v1/auth/registrations",
                sessions: "api/v1/auth/sessions",
                passwords: "api/v1/auth/passwords",
                confirmations: "api/v1/auth/confirmations",
              }
      resources :users, only: %i[index]
      resources :fish, only: %i[index]
    end
  end
end
