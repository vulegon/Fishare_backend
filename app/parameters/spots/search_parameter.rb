module Spots
  class SearchParameter
    include ActiveModel::Model
    include ActiveModel::Attributes

    # TRAVEL_DISTANCES_TYPE = ["10km圏内"]

    attribute :name, :string
    attribute :latitude, :float
    attribute :longitude, :float
    attribute :location, :string
    attribute :fish, array: true
    attribute :fishing_types, array: true
    attribute :travel_distances, array: true

    validate :location_must_be_found
    validate :latitude_must_be_within_0_to_90_degrees, if: -> { location.present? }
    validate :longitude_must_be_within_0_to_180_degrees, if: -> { location.present? }
    validate :fish_must_be_found, if: -> { fish.present? }
    validate :fishing_types_must_be_found, if: -> { fish.present? }
    # validate :travel_distances_must_be_found, if: -> { travel_distances.present? }　現在地からある距離までの釣り場を検索できるように改修予定

    def initialize(params)
      super(params.permit(:name, :latitude, :longitude, :location, fishing_types: [], fish: []))
    end

    private

    def location_must_be_found
      return if location.blank?
      return if Location.find_by(name: location)
      errors.add(:location, "釣り場は#{Location::NAMES}から選択する必要があります")
    end

    def latitude_must_be_within_0_to_90_degrees
      return if errors.key?(:location)
      return if ::Spot::LATITUDE_RANGE.include?(latitude)
      errors.add(:latitude, "緯度は-90°〜+90°の間である必要があります")
    end

    def longitude_must_be_within_0_to_180_degrees
      return if errors.key?(:location)
      return if ::Spot::LONGITUDE_RANGE.include?(longitude)
      errors.add(:longitude, "経度は-180°〜+180°の間である必要があります")
    end

    def fish_must_be_found
      return if fish.all? { |f| Fish.where(name: fish).pluck(:name).include?(f) }
      errors.add(:fish, "釣れる魚がデータベースに存在しない魚です")
    end

    def fishing_types_must_be_found
      return if fishing_types.all? { |fishing_type| FishingType.where(name: fishing_types).pluck(:name).include?(fishing_type) }
      errors.add(:fishing_types, "釣りの種類は#{FishingType::NAMES}から選択する必要があります")
    end
  end
end
