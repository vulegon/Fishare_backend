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

    it "関連するモデルが正しく作成および関連付けられていること" do
      subject # update_spot! メソッドを呼び出す

      # Spot モデルが正しく更新されたことは前のテストで確認しているので、ここでは存在のみを確認
      expect(Location.exists?(name: location.name)).to be_truthy

      expect(Fish.exists?(name: fish_1.name)).to be_truthy
      expect(Fish.exists?(name: fish_2.name)).to be_truthy

      expect(FishingType.exists?(name: fishing_type_1.name)).to be_truthy
      expect(FishingType.exists?(name: fishing_type_2.name)).to be_truthy
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
    subject { described_class.update_spot!(update_parameter) }
    let(:before_location) { FactoryBot.create(:location, name: "川釣り") }
    let(:user) { FactoryBot.create(:user) }
    let!(:spot) { FactoryBot.create(:spot, :with_images, latitude: "36.15305354356379", longitude: "136.2725972414738", location: before_location, user_id: user.id, description: "変更前", name: "釣り場の名前変更前") }
    let(:update_parameter) { Spots::UpdateParameter.new(params, user) }

    let(:params) { ActionController::Parameters.new(id: spot.id, description: description, images: images, str_latitude: latitude, str_longitude: longitude, name: name, location: after_location.name, fish: fish, fishing_types: fishing_types) }
    let(:after_location) { FactoryBot.create(:location, name: "海釣り") }
    let(:image_1) { fixture_file_upload("spec/samples/images/ボルメテウス・サファイア・ドラゴン.jpg", "image/png") }
    let(:image_2) { fixture_file_upload("spec/samples/images/勝利宣言 鬼丸「覇」.jpg", "image/png") }
    let(:images) {
      images = [image_1, image_2]
    }
    let(:latitude) { "36.15305354356379" }
    let(:longitude) { "136.2725972414738" }
    let(:name) { "釣り場の名前" }
    let(:description) { "変更後説明" }
    let(:fish_1) { FactoryBot.create(:fish, name: "#{Fish::NAMES.first}") }
    let(:fish_2) { FactoryBot.create(:fish, name: "#{Fish::NAMES.second}") }
    let(:fish) { [fish_1.name, fish_2.name] }
    let(:fishing_type_1) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.first}") }
    let(:fishing_type_2) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.second}") }
    let(:fishing_types) { [fishing_type_1.name, fishing_type_2.name] }

    it "Spotが更新されること" do
      expect { subject }.to change { Spot.exists?(description: description, latitude: latitude.to_f, longitude: longitude.to_f, user_id: user.id, location_id: after_location.id) }.from(false).to(true)
    end

    it "関連するモデルが正しく作成および関連付けられていること" do
      subject # update_spot! メソッドを呼び出す

      # Spot モデルが正しく更新されたことは前のテストで確認しているので、ここでは存在のみを確認
      expect(Location.exists?(name: before_location.name)).to be_truthy
      expect(Location.exists?(name: after_location.name)).to be_truthy

      expect(Fish.exists?(name: fish_1.name)).to be_truthy
      expect(Fish.exists?(name: fish_2.name)).to be_truthy

      expect(FishingType.exists?(name: fishing_type_1.name)).to be_truthy
      expect(FishingType.exists?(name: fishing_type_2.name)).to be_truthy
    end
  end
end
