module Spots
  class ShowSerializer
    def initialize(spot, user)
      @spot = spot
      @user = user
    end

    def serialize_spots
      {
        id: spot.id,
        name: spot.name,
        description: spot.description,
        location: spot.location.name,
        fish: spot.fish.pluck(:name),
        fishing_types: spot.fishing_types.pluck(:name),
        images: spot.image_urls,
        editable: spot.editable?(user),
      }
    end

    private

    attr_reader :spot, :user
  end
end
