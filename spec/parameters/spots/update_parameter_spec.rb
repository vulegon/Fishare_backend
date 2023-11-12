require "rails_helper"

RSpec.describe Spots::UpdateParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(id: spot_id) }
  let(:spot) { FactoryBot.create(:spot) }
  let(:user) { spot.user }
  let(:spot_id) { spot.id }

  describe "#valid" do
    subject { described_class.new(params, user) }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "釣り場が見つからない時" do
        let(:spot_id) { SecureRandom.uuid }
        it { should be_invalid }
      end

      context "ユーザーが作成者ではないとき" do
        let(:user) { FactoryBot.build(:user, email: 'tester1-1@fishare.com') }
        it { should be_invalid }
      end
    end
  end
end
