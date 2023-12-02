module Spots
  class SpotSerializer < ActiveModel::Serializer
    attributes :id, :name, :latitude, :longitude, :description, :location, :fish, :fishing_types

    def initialize(object, options = {})
      @cache_locations = options[:cache_locations]
      @cache_fish = options[:cache_fish]
      @cache_fishing_types = options[:cache_fishing_types]
      super(object)
    end

    def location
      cache_locations[object.id]
    end

    def fish
      cache_fish[object.id]
    end

    def fishing_types
      cache_fishing_types[object.id]
    end

    attr_reader :cache_locations, :cache_fish, :cache_fishing_types
  end
end
