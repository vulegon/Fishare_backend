require "rails_helper"

RSpec.describe Api::V1::FishController, type: :request do
  describe "GET #index" do
    subject {
      get api_v1_fish_index_path
      response
    }
    let!(:fish1) { FactoryBot.create(:fish, name: "カサゴ") }
    let!(:fish2) { FactoryBot.create(:fish, name: "タコ") }

    context "魚の配列が返ること" do
      it {
        should have_http_status(:ok)
        expect(JSON.parse(response.body)["fish"]).to contain_exactly(fish1.name, fish2.name)
      }
    end
  end
end
