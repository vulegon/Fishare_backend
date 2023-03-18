module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController
        # ユーザーを作成します
        # @param name[<String>] 入力した名前 
        # @param email[<String>] 入力したメールアドレス
        # @param password[<String>] 入力したパスワード
        def create
          create_params = ::Users::Registrations::CreateParameter.new(params)
      
          if create_params.invalid?
            render_parameter_error(create_params) and return
          end
      
          json = { message: 'ユーザー登録完了しました' }
          render status: :ok, json: json
        end
      end
    end
  end
end
