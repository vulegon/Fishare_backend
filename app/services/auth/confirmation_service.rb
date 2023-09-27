module Auth
  class ConfirmationService
    class << self
      # ユーザー認証を行います
      # @param params[<Auth::ConfirmationParameter>] 釣り場作成のパラメータ
      # @return void
      def confirm_user!(params)
        user = params.user
        user.confirm
        sign_in(user)
      end
    end
  end
end
