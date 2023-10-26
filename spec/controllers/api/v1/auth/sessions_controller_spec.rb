require "rails_helper"

RSpec.describe Api::V1::Auth::SessionsController, type: :request do
  describe "POST #create" do
    subject {
      post api_v1_user_session_path, params: params
      response
    }
    let!(:user) { FactoryBot.create(:user, email: valid_email, password: valid_password, password_confirmation: valid_password) }
    let(:valid_email) { 'tester1-1@example.com' }
    let(:valid_password) { 'Password2' }
    let(:params) { { email: email, password: password } }
    let(:email) { valid_email }
    let(:password) { valid_password }

    context "パラメーターが正しいとき" do
      it {
        should have_http_status(:ok)
      }
    end

    context "パラメーターが間違っているとき" do
      let(:password) { 'invalid_password' }

      it {
        should have_http_status(:bad_request)
      }
    end
  end

  describe "DELETE #destroy" do
    subject {
      delete destroy_api_v1_user_session_path, headers: auth_headers
      response
    }
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    it "ログアウトされていること" do
      should have_http_status(:ok)
      expect(user.reload.tokens).to eq({})
    end
  end
end
