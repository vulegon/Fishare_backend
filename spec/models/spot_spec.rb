require "rails_helper"

RSpec.describe Spot, type: :model do
  describe "#valid?" do
    subject { FactoryBot.build(:spot, name: name, latitude: latitude, longitude: longitude, description: description, location_id: location.id, user_id: user.id) }
    let(:name) { "釣り場1" }
    let(:latitude) { 36.063053704526226 }
    let(:longitude) { 136.22288055523217 }
    let(:description) { "説明1" }
    let(:user) { FactoryBot.create(:user) }
    let(:location) { FactoryBot.create(:location) }

    context "属性が正しい時" do
      it { should be_valid }
    end

    context "属性が間違っている時" do
      context "名前が間違っているとき" do
        context "空欄のとき" do
          let(:name) { nil }
          it { should be_invalid }
        end

        context "300文字超えるとき" do
          let(:name) { "1234567890" * 30 + "1" }
          it { should be_invalid }
        end
      end

      context "説明が間違っているとき" do
        context "空欄のとき" do
          let(:description) { nil }
          it { should be_invalid }
        end

        context "1000文字超えるとき" do
          let(:description) { "1234567890" * 100 + "1" }
          it { should be_invalid }
        end
      end

      context "緯度が間違っているとき" do
        context "空欄のとき" do
          let(:latitude) { nil }
          it { should be_invalid }
        end

        context "範囲外のとき" do
          let(:latitude) { -180.0 }
          it { should be_invalid }
        end
      end

      context "経度が間違っているとき" do
        context "空欄のとき" do
          let(:longitude) { nil }
          it { should be_invalid }
        end

        context "範囲外のとき" do
          let(:latitude) { -300.0 }
          it { should be_invalid }
        end
      end
    end
  end

  describe "#image_urls" do
    subject { FactoryBot.build(:spot).image_urls }

    it "imageのURLが返ってくること" do
      expect(subject.length).to eq(2)
      expect(subject).to all(match(Rails.application.routes.default_url_options[:host]))
    end
  end

  describe "#editable?" do
    subject { spot.editable?(user) }
    let(:spot) { FactoryBot.build(:spot) }

    context "引数のユーザーと釣り場のユーザーに関して" do
      context "一致するとき" do
        let(:user) { spot.user }
        it {
          is_expected.to eq(true)
        }
      end

      context "一致しないとき" do
        let(:user) { FactoryBot.build(:user, email: "walkurepqrt@icloud.com") }
        it {
          is_expected.to eq(false)
        }
      end
    end
  end
end
