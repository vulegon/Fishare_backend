module Spots
  class DestroyParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :string #釣り場のid

    validate :spot_must_be_exist

    def initialize(params, current_user)
      super(params.permit(:id))
      @spot = Spot.find_by(id: params[:id], user_id: current_user.id)
    end

    attr_reader :spot

    private

    def spot_must_be_exist
      return if spot.present?
      errors.add(:id, "ログイン中のユーザーアカウントに関連付けられた釣り場が見つかりませんでした")
    end
  end
end
