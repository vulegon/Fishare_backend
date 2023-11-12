module Spots
  class UpdateParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :string #釣り場のid
    attribute :name, :string
    attribute :description, :string
    attribute :location, :string
    attribute :images, :binary
    attribute :fish, array: true
    attribute :fishing_types, array: true

    validate :spot_must_be_found

    def initialize(params, current_user)
      super(params.permit(:id, :description, :location, :name, fishing_types: [], images: [], fish: []))
      @spot = Spot.find_by(id: params[:id], user_id: current_user&.id)
    end

    attr_reader :spot

    private

    def spot_must_be_found
      return if spot.present?
      errors.add(:id, "ログイン中のユーザーアカウントに関連付けられた釣り場が見つかりませんでした")
    end
  end
end
