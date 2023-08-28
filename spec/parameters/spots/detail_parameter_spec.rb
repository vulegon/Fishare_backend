require "rails_helper"

RSpec.describe Spots::DetailParameter, type: :parameter do
  let(:params) { ActionController::Parameters.new(id: spot_id) }
  let(:spot) { FactoryBot.create(:spot, :with_images) }

  describe "#valid" do
    subject { described_class.new(params) }

    context "パラメーターが正しいとき" do
      let(:spot_id) { spot.id }

      it { should be_valid }
    end

    context "パラメーターが正しくないとき" do
      context "釣り場が見つからない時" do
        let(:spot_id) { '' }
        it { should be_invalid }
      end
    end
  end
end
