module Auth
  class ConfirmationParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :confirmation_token, :string

    validate :confirmation_token_must_be_exist

    def initialize(params)
      super(params.permit(:confirmation_token))
      @user = User.find_by_confirmation_token(params[:confirmation_token])
    end

    attr_reader :user

    private

    def confirmation_token_must_be_exist
      return if user
      errors.add(:confirmation_token, 'トークンが見つかりませんでした。認証メールを再送して認証を行ってください')
    end
  end
end

