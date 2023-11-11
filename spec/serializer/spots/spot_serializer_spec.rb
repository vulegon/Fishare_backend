require "rails_helper"

RSpec.describe Spots::SpotSerializer do
  describe "#serialize_spots" do
    subject { described_class.new(spots).serialize_spots }
    let!(:spot) { FactoryBot.create(:spot) }
    let!(:spots) { Spot.all }
    let!(:fishing_type1) { FactoryBot.create(:fishing_type) }
    let!(:spot_fishing_type) { FactoryBot.create(:spot_fishing_type, spot_id: spot.id, fishing_type_id: fishing_type1.id) }
    let!(:spot_fishing_types) { spot.fishing_types << [fishing_type1] }
    let!(:fish) { FactoryBot.create(:fish) }
    let!(:spot_fishing_types) { spot.fish << [fish] }
    it {
      expect(subject[0]).to eq({ id: spot.id,
                                 name: spot.name,
                                 lat: spot.latitude,
                                 lng: spot.longitude,
                                 description: spot.description,
                                 location: spot.location.name,
                                 fish: [fish.name],
                                 fishing_types: [fishing_type1.name] })
    }
  end
end
