module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        # ログイン
        def create
          create_params = ::Auth::Sessions::CreateParameter.new(params)

          if create_params.invalid?
            render_parameter_error(create_params) and return
          end

          user = create_params.user
          user.skip_password_validation
          token = user.create_new_auth_token
          response.headers.merge!(token)

          json = {
            message: "ログインしました"
          }

          render status: :ok, json: json
        end

        # ログアウト
        def destroy
          # ユーザーセッションを削除
          sign_out(current_api_v1_user)

          # トークンを無効化
          current_api_v1_user.tokens = {}
          current_api_v1_user.save

          json = {
            message: "ログアウトしました"
          }

          render status: :ok, json: json
        end
      end
    end
  end
end
