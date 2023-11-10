require "rails_helper"

RSpec.describe Location, type: :model do
  describe "#valid?" do
    subject { FactoryBot.build(:location, name: name) }

    context "名前が有効な値のとき" do
      let(:name) { "#{Location::NAMES.first}" }
      it { should be_valid }
    end

    context "名前が無効な値のとき" do
      context "名前がNAMESにはない値のとき" do
        let(:name) { "invalid_name" }
        it { should be_invalid }
      end
    end
  end
end
