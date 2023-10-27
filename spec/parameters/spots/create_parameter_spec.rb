require "rails_helper"

RSpec.describe Spots::CreateParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(description: description, images: images, str_latitude: latitude, str_longitude: longitude, name: name) }
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
  let(:images) {
    images = []
    images << image_1
    images << image_2
    images
  }
  let(:latitude) { '36.15305354356379' }
  let(:longitude) { '136.2725972414738' }
  let(:name) { "釣り場の名前" }
  let(:user) { FactoryBot.create(:user) }

  describe "#valid" do
    subject { described_class.new(params, user) }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "緯度が空の時" do
        let(:latitude) { '' }
        it { should be_invalid }
      end

      context "経度が空の時" do
        let(:longitude) { '' }
        it { should be_invalid }
      end

      context "緯度が-90°から90°の範囲ではない時" do
        let(:latitude) { '-91.00000000000000' }
        it { should be_invalid }
      end

      context "経度が-180°から180°の範囲ではない時" do
        let(:longitude) { '181.00000000000000' }
        it { should be_invalid }
      end

      context "user_idが空の時" do
        let(:user_id) { "" }
        it { should be_invalid }
      end

      context "釣り場の名前が空の時" do
        let(:name) { "" }
        it { should be_invalid }
      end
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
                       user_id: user_id,
                     })
    end
  end
end
