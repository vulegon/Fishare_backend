class SpotSerializer
  def initialize(spots)
    @spots = spots
  end

  attr_reader :spots

  def formatted_data
    return if spots.blank?
    spot_positions = spots.pluck(:id, :latitude,:longitude, :name)
    serialized_spots = []

    spot_positions.each do |spot_position|
      id = spot_position[0]
      latitude = spot_position[1]
      longitude = spot_position[2]
      name = spot_position[3]
      data = {id: id, name: name, lat: latitude, lng: longitude }
      serialized_spots << data
    end

    serialized_spots
  end
end
