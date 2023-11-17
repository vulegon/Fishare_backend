require "rails_helper"

RSpec.describe Spots::IndexSerializer, type: :serializer do
  describe "#serialize_spots" do
    subject { described_class.new(spots).serialize_spots }
    let!(:spot) { FactoryBot.create(:spot) }
    let!(:spots) { Spot.all }
    it {
      expect(subject[0]).to eq({ id: spot.id,
                                lat: spot.latitude,
                                lng: spot.longitude })
    }
  end
end
