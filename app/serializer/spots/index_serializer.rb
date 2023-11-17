module Spots
  class IndexSerializer
    def initialize(spots)
      @spots = spots
    end

    def serialize_spots
      spots.pluck(:id, :latitude, :longitude).map { |spot_attr| { id: spot_attr[0], lat: spot_attr[1], lng: spot_attr[2] } }
    end

    private

    attr_reader :spots
  end
end
