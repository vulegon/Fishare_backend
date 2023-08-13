require "rails_helper"

RSpec.describe SpotService, type: :service do
  describe ".create_spot!" do
    subject { described_class.create_spot!(create_parameter) }
    let(:create_parameter) { Spots::CreateParameter.new(params) }
    let(:params) { ActionController::Parameters.new(description: description, images: images, str_latitude: latitude, str_longitude: longitude, user_id: user_id) }
    let(:description) { '適当な説明文' }
    let(:image_1) { fixture_file_upload('spec/samples/images/ボルメテウス・サファイア・ドラゴン.jpg', 'image/png') }
    let(:image_2) { fixture_file_upload('spec/samples/images/勝利宣言 鬼丸「覇」.jpg', 'image/png') }
    let(:images) {
      images = [image_1, image_2]
     }
    let(:latitude) { '36.15305354356379' }
    let(:longitude) { '136.2725972414738' }
    let(:user_id) { 'cognito_user' }

    it "Spotが作られること" do
      expect { subject }.to change { Spot.exists?(description: description, latitude: latitude.to_f, longitude: longitude.to_f, user_id: user_id) }.from(false).to(true)
    end
  end
end
