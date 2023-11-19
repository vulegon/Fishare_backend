require "rails_helper"

RSpec.describe SpotService, type: :service do
  describe ".create_spot!" do
    subject { described_class.create_spot!(create_parameter) }
    let(:create_parameter) { Spots::CreateParameter.new(params, user) }
    let(:params) { ActionController::Parameters.new(description: description, images: images, str_latitude: latitude, str_longitude: longitude, name: name, location: location.name, fish: fish, fishing_types: fishing_types) }
    let(:description) { "適当な説明文" }
    let(:image_1) { fixture_file_upload("spec/samples/images/ボルメテウス・サファイア・ドラゴン.jpg", "image/png") }
    let(:image_2) { fixture_file_upload("spec/samples/images/勝利宣言 鬼丸「覇」.jpg", "image/png") }
    let(:images) {
      images = [image_1, image_2]
    }
    let(:latitude) { "36.15305354356379" }
    let(:longitude) { "136.2725972414738" }
    let(:name) { "釣り場の名前" }
    let(:user) { FactoryBot.create(:user) }
    let(:location) { FactoryBot.create(:location) }
    let(:fish_1) { FactoryBot.create(:fish, name: "#{Fish::NAMES.first}") }
    let(:fish_2) { FactoryBot.create(:fish, name: "#{Fish::NAMES.second}") }
    let(:fish) { [fish_1.name, fish_2.name] }
    let(:fishing_type_1) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.first}") }
    let(:fishing_type_2) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.second}") }
    let(:fishing_types) { [fishing_type_1.name, fishing_type_2.name] }

    it "Spotが作られること" do
      expect { subject }.to change { Spot.exists?(description: description, latitude: latitude.to_f, longitude: longitude.to_f, user_id: user.id, location_id: location.id) }.from(false).to(true)
    end
  end

  describe ".destroy_spot!" do
    subject { described_class.destroy_spot!(destroy_parameter) }
    let(:destroy_parameter) { Spots::DestroyParameter.new(params, user) }
    let(:params) { ActionController::Parameters.new(id: spot.id) }
    let!(:spot) { FactoryBot.create(:spot) }
    let(:user) { spot.user }

    it "釣り場が削除されること" do
      expect { subject }.to change { Spot.exists?(id: spot.id, user_id: user.id) }.from(true).to(false)
    end
  end

  describe ".update_spot!" do

  end
end
