module Users
  class RegistrationService
    class << self
      # ユーザーを作成します
      # @param params[<Users::Registrations::CreateParameter>] ユーザー作成のパラメータ
      # @return user[<User>] 作成したユーザー
      def create!(params)
        user = User.create!(
          name: params.name,
          email: params.email,
          password: params.password
        )
  
        user
      end
    end
  end
end
