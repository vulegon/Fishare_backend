module Spots
  class CreateParameter
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :name, :string
    #formDataでは文字列でしか送れないので仕方なく文字列型とする
    attribute :str_latitude, :string
    attribute :str_longitude, :string
    attribute :description, :string
    attribute :location, :string
    attribute :images, :binary
    attribute :fish, array: true
    attribute :fishing_types, array: true

    validates :name, presence: true, length: { maximum: Spot::NAME_MAXIMUM_LIMIT }
    validates :description, presence: true, length: { maximum: Spot::DESCRIPTION_MAXIMUM_LIMIT }
    validate :latitude_must_be_exist
    validate :longitude_must_be_exist

    # TODO 各Validatorのテストを追加すること
    validates_with Spots::LocationValidator
    validates_with Spots::PositionValidator
    validates_with Spots::FishValidator
    validates_with Spots::FishingTypeValidator

    def initialize(params, current_user)
      super(params.permit(:str_latitude, :str_longitude, :description, :location, :name, fishing_types: [], images: [], fish: []))
      @latitude = str_latitude.to_f
      @longitude = str_longitude.to_f
      @user = current_user
      @location_record = Location.find_by(name: location)
      @fish_record = Fish.where(name: fish)
      @fishing_types_record = FishingType.where(name: fishing_types)
    end

    attr_reader :latitude, :longitude, :user, :location_record, :fish_record, :fishing_types_record

    def model_attributes
      {
        name: name,
        description: description,
        images: images,
        latitude: latitude,
        longitude: longitude,
        location_id: location_record.id,
      }
    end

    private

    def latitude_must_be_exist
      return unless latitude.to_i.zero?
      errors.add(:str_latitude, "緯度情報が存在しません")
    end

    def longitude_must_be_exist
      return unless longitude.to_i.zero?
      errors.add(:str_longitude, "経度情報が存在しません")
    end
  end
end
