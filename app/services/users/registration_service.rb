module Users
  class RegistrationService
    class << self
      # メール認証済みでないユーザーを作成し、指定したメールアドレスにメールを送信します。
      # @param params[<::Users::Registrations::CreateParameter>] ユーザー作成に必要なパラメータ
      # @return void
      def create_user!(params)
        ActiveRecord::Base.transaction do
          confirmation_token = ::User.set_email_confirmation
          user = User.new(email: params.email, confirmation_token: confirmation_token)
          user.save!(validate: false)
          ::UserMailer.registration_confirmation(user).deliver_later
        end
      end
    end
  end
end
