require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe '#valid' do
    context '緯度が入力されていないとき' do
      let!(:spot) { FactoryBot.build(:spot, longitude: 123 ) }
      it { expect(subject).to be_invalid }
    end

    context '経度が入力されていないとき' do
      FactoryBot.build(:spot, latitude: 123 )
      it { expect(subject).to be_invalid }
    end
  end
end
