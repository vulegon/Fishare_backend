require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :request do
  describe "GET #index" do
    subject {
      get api_v1_users_path, headers: auth_headers
      response
    }
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    context "ログインしているとき" do
      it {
        should have_http_status(:ok)
        expect(JSON.parse(response.body)["is_login"]).to eq(true)
      }
    end

    context "ログインしていないとき" do
      let(:auth_headers) { {} }

      it {
        is_expected.to have_http_status(:ok)
        expect(JSON.parse(response.body)["is_login"]).to eq(false)
      }
    end
  end
end
