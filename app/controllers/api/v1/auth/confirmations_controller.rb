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

          # TODO 本番サーバーが決まり次第、修正
          redirect_path = if Rails.env.production?
                            # 本番環境のみの処理
                            'http://localhost:3000'
                          else
                            # 開発環境のみの処理
                            'http://localhost:3000'
                          end

          redirect_to(redirect_path, allow_other_host: true)
        end
      end
    end
  end
end
