module Spots
  class SearchParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :latitude, :float
    attribute :longitude, :float
    attribute :name, :string
    attribute :location, :string
    attribute :fish, array: true
    attribute :fishing_types, array: true

    validate :latitude_and_longitude_must_be_exist

    def initialize(params, current_user)
      super(params.permit(:latitude, :longitude, :location, :name, fishing_types: [], fish: []))
    end

    private

    def latitude_and_longitude_must_be_exist
      return if longitude.present? && latitude.present?
      errors.add(:id, "緯度経度が取得できませんでした")
    end
  end
end
