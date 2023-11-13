require "rails_helper"

RSpec.describe Spots::UpdateParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(id: spot_id, description: description, images: images, name: name, location: location_name, fish: fish, fishing_types: fishing_types) }
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
  let(:name) { "釣り場の名前" }
  let(:location) { spot.location }
  let(:location_name) { location.name }
  let(:fish_1) { FactoryBot.create(:fish, name: "#{Fish::NAMES.first}") }
  let(:fish_2) { FactoryBot.create(:fish, name: "#{Fish::NAMES.second}") }
  let(:fish) { [fish_1.name, fish_2.name] }
  let(:fishing_type_1) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.first}") }
  let(:fishing_type_2) { FactoryBot.create(:fishing_type, name: "#{FishingType::NAMES.second}") }
  let(:fishing_types) { [fishing_type_1.name, fishing_type_2.name] }
  let(:spot) { FactoryBot.create(:spot) }
  let(:user) { spot.user }
  let(:spot_id) { spot.id }

  describe "#valid" do
    subject { described_class.new(params, user) }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "釣り場が見つからない時" do
        let(:spot_id) { SecureRandom.uuid }
        it { should be_invalid }
      end

      context "ユーザーが作成者ではないとき" do
        let(:user) { FactoryBot.build(:user, email: "tester1-1@fishare.com") }
        it { should be_invalid }
      end

      context "釣り場の名前が誤りのとき" do
        context "釣り場の名前が空の時" do
          let(:name) { "" }
          it { should be_invalid }
        end

        context "釣りの場の名前の文字数が300文字超えるとき" do
          let(:name) { "0123456789" * 30 + "1" }
          it { should be_invalid }
        end
      end

      context "釣り場の説明が誤りのとき" do
        context "釣り場の説明が空の時" do
          let(:description) { "" }
          it { should be_invalid }
        end

        context "釣りの場の説明の文字数が1000文字超えるとき" do
          let(:description) { "0123456789" * 100 + "1" }
          it { should be_invalid }
        end
      end
    end
  end
end
