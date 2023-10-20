module Api
  module V1
    class UsersController < ApplicationController
      # ログインユーザーを取得します
      def index
        message = current_api_v1_user ? "ログインユーザーを取得しました" : "ログインされていません"

        json = {
          message: message,
          user: current_api_v1_user,
        }

        render status: :ok, json: json
      end
    end
  end
end
