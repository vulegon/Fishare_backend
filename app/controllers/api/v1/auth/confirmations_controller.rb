module Api
  module V1
    module Auth
      class ConfirmationsController < ApplicationController
        def show
          confirm_params = ::Auth::ConfirmationParameter.new(params)

          if confirm_params.invalid?
            render_parameter_error(confirm_params) and return
          end

          user = confirm_params.user
          user.confirm
          sign_in(user)

          redirect_path = Rails.application.config.frontend_url

          redirect_to(redirect_path, allow_other_host: true)
        end
      end
    end
  end
end
