module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController
        # ユーザーを作成します。作成時パラメーターのemailに認証メールを送ります。
        # POST api/v1/users
        def create
          create_params = ::Users::Registrations::CreateParameter.new(params)

          if create_params.invalid?
            render_parameter_error(create_params) and return
          end

          ::Users::RegistrationService.create_user!(create_params)
      
          json = { message: 'ユーザー登録のメールを送信しました。' }
          render status: :ok, json: json
        end
      end
    end
  end
end
