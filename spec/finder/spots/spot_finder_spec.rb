require "rails_helper"

RSpec.describe Spots::SpotFinder, type: :finder do
  describe "#search" do
    subject { described_class.new(params) }
    let(:search_params) { Spots::SearchParameter.new(params) }
    let(:params) { ActionController::Parameters.new(name: name, latitude: latitude, longitude: longitude, location: location, fish: fish, fishing_types: fishing_types) }
    let(:name) { "釣り場の名前" }
    let(:latitude) { 36.15305354356379 }
    let(:longitude) { 136.2725972414738 }
    let(:location) { FactoryBot.create(:location).name }
    let(:fish_1) { FactoryBot.create(:fish, name: "#{Fish::NAMES.first}") }
    let(:fish_2) { FactoryBot.create(:fish, name: "#{Fish::NAMES.second}") }
    let(:fish) { [fish_1.name, fish_2.name] }
    let(:fishing_type_1) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.first}") }
    let(:fishing_type_2) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.second}") }
    let(:fishing_types) { [fishing_type_1.name, fishing_type_2.name] }

    context "釣り場の名前が設定されているとき" do
    end

    context "釣り場の種類が設定されているとき" do
    end

    context "魚の名前が設定されているとき" do
    end

    context "釣りの種類が設定されているとき" do
    end
  end
end
