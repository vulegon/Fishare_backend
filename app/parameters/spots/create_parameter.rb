module Spots
  class CreateParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    LATITUDE_RANGE = -90..90
    LONGITUDE_RANGE = -180..180
    FISHING_TYPE = ["海釣り", "川釣り"]

    attribute :name, :string
    attribute :description, :string
    attribute :images, :binary
    attribute :str_latitude, :string  #formDataでは文字列でしか送れないので仕方なく文字列型とする
    attribute :str_longitude, :string
    attribute :fish
    attribute :fishing_type, :string

    validate :name_must_be_exist
    validate :description_must_be_exist
    validate :latitude_must_be_exist
    validate :longitude_must_be_exist
    validate :latitude_must_be_within_0_to_90_degrees
    validate :longitude_must_be_within_0_to_180_degrees
    validate :fish_must_be_exist
    validate :fishing_type_must_be_exist

    def initialize(params)
      super(params.permit(:str_latitude, :str_longitude, :description, :user_id, :name, :fishing_type, images: [], fish: []))
      @latitude = str_latitude.to_f
      @longitude = str_longitude.to_f
    end

    attr_reader :latitude, :longitude

    def model_attributes
      {
        name: name,
        description: description,
        images: images,
        latitude: latitude,
        longitude: longitude,
        user_id: user_id,
      }
    end

    private

    def name_must_be_exist
      return if name.present?
      errors.add(:latitude, "釣り場の名前が未入力です")
    end

    def description_must_be_exist
      return if description.present?
      errors.add(:description, "釣り場の説明が未入力です")
    end

    def latitude_must_be_exist
      return unless latitude.to_i.zero?
      errors.add(:latitude, "緯度情報が存在しません")
    end

    def longitude_must_be_exist
      return unless longitude.to_i.zero?
      errors.add(:longitude, "経度情報が存在しません")
    end

    def latitude_must_be_within_0_to_90_degrees
      return if errors.key?(:latitude)
      return if LATITUDE_RANGE.include?(latitude)
      errors.add(:latitude, "緯度は-90°〜+90°の間である必要があります")
    end

    def longitude_must_be_within_0_to_180_degrees
      return if errors.key?(:longitude)
      return if LONGITUDE_RANGE.include?(longitude)
      errors.add(:longitude, "経度は-180°〜+180°の間である必要があります")
    end

    def fish_must_be_exist
      return if fish.present?
      errors.add(:fish, "釣れる魚を入力してください")
    end

    def fishing_type_must_be_exist
      return if FISHING_TYPE.include?(fishing_type)
      errors.add(:fishing_type, "釣りの種類は#{FISHING_TYPE}から選択する必要があります")
    end
  end
end
