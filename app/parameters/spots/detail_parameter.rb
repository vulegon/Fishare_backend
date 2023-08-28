module Spots
  class DetailParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :string

    validate :spot_must_be_exist

    def initialize(params)
      super(params.permit(:id))
      @spot = Spot.find_by(id: params[:id])
    end

    attr_reader :spot

    private

    def spot_must_be_exist
      return if spot
      errors.add(:id, '釣り場が見つかりません')
    end
  end
end
