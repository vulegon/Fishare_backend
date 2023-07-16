require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_user_registration_path(params)
      response
    }
    let(:params) { {email: email} }
    let(:email) { 'example@example.com' }

    context 'when params is valid' do
      it { expect(subject).to have_http_status(:ok) }
    end

    context 'when params is invalid' do
      let(:email) { 'aaa' }
      it { expect(subject).to have_http_status(:bad_request) }
    end
  end
end
