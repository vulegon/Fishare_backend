require 'rails_helper'

RSpec.describe SpotSerializer do
  describe '#formatted_data' do
    subject { described_class.new(spots).formatted_data }
    let!(:spot_1) { FactoryBot.create(:spot, latitude: 34.0, longitude: 130.0, name: "釣り場1") }
    let!(:spot_2) { FactoryBot.create(:spot, latitude: 34.0, longitude: 131.0, name: "釣り場2") }
    let!(:spots) { Spot.all }
    it {
      expect(subject[0]).to eq({id: spot_1.id, lat: spot_1.latitude, lng: spot_1.longitude, name: spot_1.name})
      expect(subject[1]).to eq({id: spot_2.id, lat: spot_2.latitude, lng: spot_2.longitude, name: spot_2.name})
    }
  end
end
