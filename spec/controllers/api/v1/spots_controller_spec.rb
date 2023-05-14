require 'rails_helper'

RSpec.describe Api::V1::SpotsController, type: :request do
  describe 'GET #index' do
    subject {
      get api_v1_spots_path
      response
    }
    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST #create' do
    subject {
      post api_v1_spots_path, params: params
      response
    }
    let(:params) { { description: description, images: images, latitude: latitude, longitude: longitude } }
    let(:description) { '適当な説明文' }
    let(:image_1) {
      ActionDispatch::Http::UploadedFile.new(
        filename: 'ボルメテウス・サファイア・ドラゴン.jpg',
        type: 'image/png',
        tempfile: File.open(Rails.root.join('spec', 'samples', 'images','ボルメテウス・サファイア・ドラゴン.jpg'))
      )
    }
    let(:image_2) {
      ActionDispatch::Http::UploadedFile.new(
        filename: '勝利宣言 鬼丸「覇」.jpg',
        type: 'image/png',
        tempfile: File.open(Rails.root.join('spec', 'samples', 'images','勝利宣言 鬼丸「覇」.jpg'))
      )
    }
    let(:images) {
      images = []
      images << image_1
      images << image_2
      images
     }
    let(:latitude) { 36.15305354356379 }
    let(:longitude) { 136.2725972414738 }

    context 'when params is valid' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when params is invalid' do
      let(:latitude) { { } }
      it { is_expected.to have_http_status(:bad_request) }
    end
  end
end
