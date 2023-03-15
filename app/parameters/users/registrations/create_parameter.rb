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

      def initialize(params)
        super(params.permit(self.class.attribute_names))
        @user = User.find_by(email: email)
      end

      attr_reader :user

      private

      def email_is_not_registered
        return if user.nil?

        errors.add(:email, '既に登録されているメールアドレスです')
      end
    end
  end
end
