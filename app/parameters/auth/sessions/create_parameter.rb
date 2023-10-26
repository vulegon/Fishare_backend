module Auth
  module Sessions
    class CreateParameter
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :email, :string
      attribute :password, :string

      validate :user_must_be_exist_by_email
      validate :password_must_be_valid

      def initialize(params)
        super(params.permit(:email,:password))
        @user = User.valid.find_by(email: params[:email])
      end

      attr_reader :user

      private

      def user_must_be_exist_by_email
        return if user.present?
        errors.add(:email, "メールアドレスまたはパスワードが間違っています") #メールアドレスかパスワードかのどっちが間違っているかは教えない
      end

      def password_must_be_valid
        return if errors.key?(:email)
        return if user.valid_password?(password)
        errors.add(:password, "メールアドレスまたはパスワードが間違っています") #メールアドレスかパスワードかのどっちが間違っているかは教えない
      end
    end
  end
end
