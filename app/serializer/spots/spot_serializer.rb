module Spots
  class SpotSerializer
    def initialize(spots)
      @spots = spots
    end

    attr_reader :spots

    def serialize_spots
      serialized_spots = []
      spots.each do |spot|
        serialized_spot = {
          id: spot.id,
          name: spot.name,
          latitude: spot.latitude,
          longitude: spot.longitude,
          description: spot.description,
          location: location_by_spot_id(spot.id),
          fish: fish_by_spot_id(spot.id),
          fishing_types: fishing_types_by_spot_id(spot.id),
        }
        serialized_spots << serialized_spot
      end

      serialized_spots
    end

    private

    def cache_locations
      @cache_locations ||= spots.joins(:location).pluck(:id, "locations.name").to_h
    end

    def location_by_spot_id(spot_id)
      cache_locations[spot_id]
    end

    def cache_fish
      @cache_fish ||= spots.joins(:fish).pluck(:id, "fish.name").
        each_with_object({}) do |(spot_id, fish_name), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fish_name
      end
    end

    def fish_by_spot_id(spot_id)
      cache_fish[spot_id]
    end

    def cache_fishing_types
      @cache_fishing_types ||= spots.joins(:fishing_types).pluck(:id, "fishing_types.name").
        each_with_object({}) do |(spot_id, fishing_type), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fishing_type
      end
    end

    def fishing_types_by_spot_id(spot_id)
      cache_fishing_types[spot_id]
    end
  end
end
