require "rails_helper"

RSpec.describe Auth::Sessions::CreateParameter, type: :parameter do
  describe "#valid" do
    subject { described_class.new(params) }
    let(:params) { ActionController::Parameters.new(email: email, password: password) }
    let!(:user) { FactoryBot.create(:user, email: valid_email, password: valid_password, password_confirmation: valid_password) }
    let(:valid_email) { 'tester1-1@example.com' }
    let(:valid_password) { 'Password2' }
    let(:email) { valid_email }
    let(:password) { valid_password }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが間違っているとき" do
      context "メールアドレスが間違っているとき" do
        let(:email) { "invalid_email" }
        it { should be_invalid }
      end

      context "パスワードが間違っているとき" do
        let(:password) { "invalid_password" }
        it { should be_invalid }
      end
    end
  end
end
