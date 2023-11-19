require "rails_helper"

RSpec.describe Spots::SearchParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(name: name, latitude: latitude, longitude: longitude, location: location, fish: fish, fishing_types: fishing_types) }
  let(:name) { "釣り場の名前" }
  let(:latitude) { 36.15305354356379 }
  let(:longitude) { 136.2725972414738 }
  let(:user) { FactoryBot.create(:user) }
  let(:location) { FactoryBot.create(:location).name }
  let(:fish_1) { FactoryBot.create(:fish, name: "#{Fish::NAMES.first}") }
  let(:fish_2) { FactoryBot.create(:fish, name: "#{Fish::NAMES.second}") }
  let(:fish) { [fish_1.name, fish_2.name] }
  let(:fishing_type_1) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.first}") }
  let(:fishing_type_2) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.second}") }
  let(:fishing_types) { [fishing_type_1.name, fishing_type_2.name] }

  describe "#valid" do
    subject { described_class.new(params) }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "緯度が-90°から90°の範囲ではない時" do
        let(:latitude) { -91.00000000000000 }
        it { should be_invalid }
      end

      context "経度が-180°から180°の範囲ではない時" do
        let(:longitude) { 181.00000000000000 }
        it { should be_invalid }
      end

      context "釣りの種類の名前が誤っているとき" do
        let(:fishing_types) { ["存在しない釣りの種類"] }
        it { should be_invalid }
      end

      context "魚の種類の名前が誤っているとき" do
        let(:fish) { ["データベースに存在しない魚"] }
        it { should be_invalid }
      end

      context "釣り場の種類が誤っているとき" do
        let(:location) { "データベースに存在しない釣り場の種類" }
        it { should be_invalid }
      end
    end
  end
end
