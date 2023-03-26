module Users
  module Registrations
    class CreateParameter
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :name, :string
      attribute :email, :string
      attribute :password, :string

      validates :name, presence: true, length: { maximum: 20 }
      validates :email, presence: true
      validates :password, presence: true, length: { minimum: 8, maximum: 128 }
      validate :email_is_not_registered
      validate :email_must_be_valid_format, if: -> { email.present? }
      validate :password_must_be_valid_format, if: -> { password.present? }

      def initialize(params)
        super(params.permit(self.class.attribute_names))
        @user = User.find_by(email: email)
      end

      attr_reader :user

      private

      def email_is_not_registered
        return if user.nil?

        errors.add(:email, 'は既に登録されているメールアドレスです')
      end

      def email_must_be_valid_format
        return if email =~ ::User::VALID_EMAIL_REGEX

        errors.add(:email, 'は正しいメールアドレスの形式ではありません')
      end

      def password_must_be_valid_format
        return if password =~ ::User::VALID_PASSWORD_REGEX

        errors.add(:password, 'は英小文字と数字の両方を含める必要があります')
      end
    end
  end
end
