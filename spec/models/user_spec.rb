require "rails_helper"

RSpec.describe User, type: :model do
  describe "#valid?" do
    subject { FactoryBot.build(:user).valid? }

    context "パラメーターが正しい時" do
      it { should be_valid }
    end
  end
end
