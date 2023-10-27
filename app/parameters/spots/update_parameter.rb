module Spots
  class UpdateParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :string #釣り場のid
    attribute :name, :string #釣り場のid
    attribute :description, :string
    attribute :location, :string
    attribute :images, :binary
    attribute :fish, array: true
    attribute :fishing_types, array: true

    def initialize(params, current_user)
      super(params.permit(:id))
      @spot = Spot.find_by(id: params[:id], user_id: current_user.id)
    end

    attr_reader :spot

    private

    def name_must_be_exist
      return if spot.present?
      errors.add(:id, "ログイン中のユーザーアカウントに関連付けられた釣り場が見つかりませんでした")
    end
  end
end
