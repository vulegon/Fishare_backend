require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :request do
  describe "GET #index" do
    subject {
      get api_v1_users_path, headers: auth_headers
      response
    }
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:json) { JSON.parse(response.body) }

    context "ログインしているとき" do
      it {
        should have_http_status(:ok)
        expect(json["user"]["id"]).to eq(user.id)
      }
    end

    context "ログインしていないとき" do
      let(:auth_headers) { {} }

      it {
        is_expected.to have_http_status(:ok)
        expect(json["user"]).to eq(nil)
      }
    end
  end
end
