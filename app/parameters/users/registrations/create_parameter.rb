module Users
  module Registrations
    class CreateParameter
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :email, :string

      validates :email, presence: true
      validate :email_is_not_registered
      validate :email_must_be_valid_format, if: -> { email.present? }

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
    end
  end
end
