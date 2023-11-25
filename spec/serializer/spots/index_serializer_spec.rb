require "rails_helper"

RSpec.describe Spots::IndexSerializer, type: :serializer do
  describe "#serialize_spots" do
    subject { described_class.new(spot).as_json }
    let!(:spot) { FactoryBot.create(:spot) }
    it {
      expect(subject).to include({ id: spot.id,
                                   latitude: spot.latitude,
                                   longitude: spot.longitude })
    }
  end
end
