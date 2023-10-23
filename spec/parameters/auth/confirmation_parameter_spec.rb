require "rails_helper"

RSpec.describe Auth::ConfirmationParameter, type: :parameter do
  describe "#valid" do
    subject { described_class.new(params) }
    let(:params) { ActionController::Parameters.new(confirmation_token: confirmation_token) }

    context "パラメーターが正しいとき" do
      let!(:user) { FactoryBot.create(:user) }
      let(:confirmation_token) { user.confirmation_token }
      it { should be_valid }
    end

    context "パラメーターが間違っているとき" do
      context "認証トークンに一致するユーザーが存在しないとき" do
        let(:confirmation_token) { "invalid_token" }
        it { should be_invalid }
      end
    end
  end
end
