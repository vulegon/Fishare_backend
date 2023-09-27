module Auth
  module Sessions
    class CreateParameter
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :email, :string
      attribute :password, :string

      validate :valid_email_and_password

      def initialize(params)
        super(params.permit(:email,:password))
        @user = User.valid.find_by(email: params[:email])
      end

      attr_reader :user

      private

      def valid_email_and_password
        return if user.valid_password?(password) && user.present?
        errors.add(:password, "メールアドレスまたはパスワードが間違っています") #メールアドレスかパスワードかのどっちが間違っているかは教えない
      end
    end
  end
end
