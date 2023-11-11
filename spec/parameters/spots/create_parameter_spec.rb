require "rails_helper"

RSpec.describe Spots::CreateParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(description: description, images: images, str_latitude: latitude, str_longitude: longitude, name: name, location: location.name, fish: fish, fishing_types: fishing_types) }
  let(:description) { "適当な説明文" }
  let(:image_1) {
    ActionDispatch::Http::UploadedFile.new(
      filename: "ボルメテウス・サファイア・ドラゴン.jpg",
      type: "image/png",
      tempfile: File.open(Rails.root.join("spec", "samples", "images", "ボルメテウス・サファイア・ドラゴン.jpg")),
    )
  }
  let(:image_2) {
    ActionDispatch::Http::UploadedFile.new(
      filename: "勝利宣言 鬼丸「覇」.jpg",
      type: "image/png",
      tempfile: File.open(Rails.root.join("spec", "samples", "images", "勝利宣言 鬼丸「覇」.jpg")),
    )
  }
  let(:images) { [image_1, image_2] }
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

  describe "#valid" do
    subject { described_class.new(params, user) }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "緯度が空の時" do
        let(:latitude) { "" }
        it { should be_invalid }
      end

      context "経度が空の時" do
        let(:longitude) { "" }
        it { should be_invalid }
      end

      context "緯度が-90°から90°の範囲ではない時" do
        let(:latitude) { "-91.00000000000000" }
        it { should be_invalid }
      end

      context "経度が-180°から180°の範囲ではない時" do
        let(:longitude) { "181.00000000000000" }
        it { should be_invalid }
      end

      context "釣り場の名前が空の時" do
        let(:name) { "" }
        it { should be_invalid }
      end

      # TODO バリデーションを追加すること
    end
  end

  describe "#model_attributes" do
    subject { described_class.new(params, user).model_attributes }

    it "与えられたパラメーターがハッシュ形式で返ること" do
      is_expected.to eq({
                       name: name,
                       description: description,
                       images: images,
                       latitude: latitude.to_f,
                       longitude: longitude.to_f,
                       location_id: location.id,
                     })
    end
  end
end
