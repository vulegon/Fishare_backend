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

          json = {
            message: 'ユーザーを認証しました',
          }

          render status: :ok, json: json
        end
      end
    end
  end
end
