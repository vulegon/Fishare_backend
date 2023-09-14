module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController

        private

        def sign_up_params
          # サインアップ時に登録できるカラムを指定
          params.permit(:name, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
