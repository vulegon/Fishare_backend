require "rails_helper"

RSpec.describe Spots::DestroyParameter, type: :parameter do
  describe "#valid" do
    subject { described_class.new(params, user) }
    let(:params) { ActionController::Parameters.new(id: spot_id) }
    let(:spot_id) { spot.id }
    let(:spot) { FactoryBot.create(:spot,user_id: spot_user.id) }
    let(:spot_user) { FactoryBot.create(:user) }
    let(:user) { spot_user }

    context "パラメーターが正しいとき" do
      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "spot_idが間違っているとき" do
        let(:spot_id) { SecureRandom.uuid }
        it { should be_invalid }
      end

      context "userが間違っているとき" do
        let(:user) { FactoryBot.build(:user) }
        it { should be_invalid }
      end
    end
  end
end
