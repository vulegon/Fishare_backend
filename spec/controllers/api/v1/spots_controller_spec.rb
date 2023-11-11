require "rails_helper"
require "action_dispatch/testing/test_process"

RSpec.describe Api::V1::SpotsController, type: :request do
  describe "GET #index" do
    subject {
      get api_v1_spots_path
      response
    }
    let!(:user) { FactoryBot.create(:user) }
    let!(:spot1) { FactoryBot.create(:spot, user: user) }
    let!(:spot2) { FactoryBot.create(:spot, user: user, location: spot1.location) }
    it { is_expected.to have_http_status(:ok) }
  end

  describe "POST #create" do
    subject {
      post api_v1_spots_path, params: params, headers: auth_headers
      response
    }
    let(:params) { { description: description, images: images, str_latitude: latitude, str_longitude: longitude, name: name, fish: [fish.name], fishing_types: [fishing_type.name], location: location.name } }
    let(:description) { "適当な説明文" }
    let(:image_1) { fixture_file_upload("spec/samples/images/ボルメテウス・サファイア・ドラゴン.jpg", "image/png") }
    let(:image_2) { fixture_file_upload("spec/samples/images/勝利宣言 鬼丸「覇」.jpg", "image/png") }
    let(:images) {
      images = [image_1, image_2]
    }
    let(:latitude) { "36.15305354356379" }
    let(:longitude) { "136.2725972414738" }
    let(:name) { "釣り場1" }
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:fish) { FactoryBot.create(:fish) }
    let(:fishing_type) { FactoryBot.create(:fishing_type) }
    let!(:location) { FactoryBot.create(:location) }

    context "パラメーターが有効なとき" do
      it { is_expected.to have_http_status(:ok) }
    end

    context "パラメーターが無効なとき" do
      let(:latitude) { {} }
      it { is_expected.to have_http_status(:bad_request) }
    end
  end

  describe "GET #show" do
    subject {
      get api_v1_spot_path(id)
      response
    }

    context "パラメーターが有効なとき" do
      let(:id) { spot.id }
      let!(:spot) { FactoryBot.create(:spot) }

      it { is_expected.to have_http_status(:ok) }
    end

    context "パラメーターが無効なとき" do
      let(:id) { SecureRandom.uuid }
      it { is_expected.to have_http_status(:bad_request) }
    end
  end
end
