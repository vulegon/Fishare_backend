require "rails_helper"

RSpec.describe Api::V1::Auth::ConfirmationsController, type: :request do
  describe "GET #show" do
    subject {
      get api_v1_user_confirmation_path, params: params
      response
    }
    let(:params) { { confirmation_token: confirmation_token } }

    context "パラメーターが正しいとき" do
      let!(:user) { FactoryBot.create(:user) }
      let(:confirmation_token) { user.confirmation_token }
      it {
        should have_http_status(:found)
      }
    end

    context "パラメーターが間違っているとき" do
      let(:confirmation_token) { "invalid_token" }
      it { should have_http_status(:bad_request) }
    end
  end
end
