module Spots
  class CreateParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    LATITUDE_RANGE = -90..90
    LONGITUDE_RANGE = -180..180

    attribute :description, :string
    attribute :images, :binary
    attribute :latitude, :float
    attribute :longitude, :float

    validate :position_must_be_exist
    validate :latitude_must_be_within_0_to_90_degrees
    validate :longitude_must_be_within_0_to_180_degrees


    def initialize(params)
      super(params.permit(:latitude, :longitude, :description, images: []))
    end

    def model_attributes
      {
        description: description,
        images: images,
        latitude: latitude,
        longitude: longitude,
      }
    end

    private

    def position_must_be_exist
      return if latitude.present? && longitude.present?
      errors.add(:position, '位置情報が存在しません')
    end

    def latitude_must_be_within_0_to_90_degrees
      return if LATITUDE_RANGE.include?(latitude)
      errors.add(:latitude, '緯度は-90°〜0〜+90°の間である必要があります')
    end

    def longitude_must_be_within_0_to_180_degrees
      return if LONGITUDE_RANGE.include?(longitude)
      errors.add(:latitude, '経度は-180°〜0〜+180°の間である必要があります')
    end
  end
end
