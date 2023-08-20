require 'rails_helper'
require 'action_dispatch/testing/test_process'

RSpec.describe Api::V1::SpotsController, type: :request do
  describe 'GET #index' do
    subject {
      get api_v1_spots_path
      response
    }
    let!(:spot1) { FactoryBot.create(:spot) }
    let!(:spot2) { FactoryBot.create(:spot) }
    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST #create' do
    subject {
      post api_v1_spots_path, params: params
      response
    }
    let(:params) { { description: description, images: images, str_latitude: latitude, str_longitude: longitude, user_id: user_id } }
    let(:description) { '適当な説明文' }
    let(:image_1) { fixture_file_upload('spec/samples/images/ボルメテウス・サファイア・ドラゴン.jpg', 'image/png') }
    let(:image_2) { fixture_file_upload('spec/samples/images/勝利宣言 鬼丸「覇」.jpg', 'image/png') }
    let(:images) {
      images = [image_1, image_2]
     }
    let(:latitude) { '36.15305354356379' }
    let(:longitude) { '136.2725972414738' }
    let(:user_id) { 'cognito_user' }


    context 'when params is valid' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when params is invalid' do
      let(:latitude) { { } }
      it { is_expected.to have_http_status(:bad_request) }
    end
  end
end
