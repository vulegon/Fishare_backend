require "rails_helper"

RSpec.describe Spots::SpotSerializer, type: :serializer do
  describe "#serialize_spots" do
    subject {
      described_class.new(spot,
                          cache_locations: cache_locations,
                          cache_fish: cache_fish,
                          cache_fishing_types: cache_fishing_types).as_json
    }
    let!(:spot) { FactoryBot.create(:spot) }
    let(:relation) { Spot.all }
    let!(:fishing_type1) { FactoryBot.create(:fishing_type) }
    let!(:spot_fishing_type) { FactoryBot.create(:spot_fishing_type, spot_id: spot.id, fishing_type_id: fishing_type1.id) }
    let!(:spot_fishing_types) { spot.fishing_types << [fishing_type1] }
    let!(:fish) { FactoryBot.create(:fish) }
    let!(:spot_fishing_types) { spot.fish << [fish] }
    let(:cache_locations) {
      relation.joins(:location).pluck(:id, "locations.name").to_h
    }
    let(:cache_fish) {
      relation.joins(:fish).pluck(:id, "fish.name").
        each_with_object({}) do |(spot_id, fish_name), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fish_name
      end
    }
    let(:cache_fishing_types) {
      relation.joins(:fishing_types).pluck(:id, "fishing_types.name").
        each_with_object({}) do |(spot_id, fishing_type), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fishing_type
      end
    }
    it {
      expect(subject).to eq({ id: spot.id,
                                 name: spot.name,
                                 latitude: spot.latitude,
                                 longitude: spot.longitude,
                                 description: spot.description,
                                 location: spot.location.name,
                                 fish: [fish.name],
                                 fishing_types: [fishing_type1.name] })
    }
  end
end
