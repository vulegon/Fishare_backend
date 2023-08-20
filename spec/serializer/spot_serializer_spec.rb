require 'rails_helper'

RSpec.describe SpotSerializer do
  describe '#formatted_data' do
    subject { described_class.new(spots).formatted_data }
    let!(:spot_1) { FactoryBot.create(:spot, latitude: 33.0, longitude: 130.0) }
    let!(:spot_2) { FactoryBot.create(:spot, latitude: 34.0, longitude: 131.0) }
    let!(:spots) { Spot.all }
    it {
      expect(subject[0]).to eq({lat: spot_1.latitude, lng: spot_1.longitude})
      expect(subject[1]).to eq({lat: spot_2.latitude, lng: spot_2.longitude})
    }
  end
end
