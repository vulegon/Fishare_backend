require "rails_helper"

RSpec.describe User, type: :model do
  describe "#valid?" do
    subject { FactoryBot.build(:user, name: name, email: email, password: password, password_confirmation: password_confirmation) }
    let(:name) { "test_user1" }
    let(:password) { "Password1" }
    let(:password_confirmation) { password }
    let(:email) { "user@example.com" }

    context "属性が正しい時" do
      it { should be_valid }
    end

    context "属性が間違っている時" do
      context "名前が間違っているとき" do
        context "空欄のとき" do
          let(:name) { nil }
          it { should be_invalid }
        end

        context "長さが20文字を超えるとき" do
          let(:name) { "012345678901234567891" }
          it { should be_invalid }
        end
      end

      context "メールアドレスが間違っているとき" do
        context "空欄のとき" do
          let(:email) { nil }
          it { should be_invalid }
        end

        context "形式が誤っているとき" do
          context "@が含まれていないとき" do
            let(:email) { "123example.com" }
            it { should be_invalid }
          end

          context "@より前に文字がないとき" do
            let(:email) { "@example.com" }
            it { should be_invalid }
          end

          context "@より後にピリオドが含まれていないとき" do
            let(:email) { "123@examplecom" }
            it { should be_invalid }
          end

          context "@より後のピリオドに1つの英小文字が含まれていないとき" do
            let(:email) { "123@example." }
            it { should be_invalid }
          end
        end

        context "既に同じメールアドレスが登録されているとき" do
          let!(:user) { FactoryBot.create(:user, name: name, email: email, password: password) }
          it { should be_invalid }
        end
      end

      context "パスワードが間違っているとき" do
        context "空欄のとき" do
          let(:password) { nil }
          it { should be_invalid }
        end

        context "長さが間違っているとき" do
          context "8文字未満のとき" do
            let(:password) { "1234567" }
            it { should be_invalid }
          end

          context "128文字以上のとき" do
            let(:password) { "1234567890" * 12 + "123456789" }
            it { should be_invalid }
          end
        end

        # TODO パスワードの形式が間違っているときのテストを追加すること
        # context "形式が間違っているとき" do
        #   context "大文字が入っていないとき" do
        #     let(:password) { "password1" }
        #     it { should be_invalid }
        #   end

        #   context "小文字が存在しないとき" do
        #     let(:password) { "PASSWORD1" }
        #     it { should be_invalid }
        #   end

        #   context "数字が存在しないとき" do
        #     let(:password) { "Passwordd" }
        #     it { should be_invalid }
        #   end
        # end
      end

      context "確認用パスワードが間違っているとき" do
        context "空欄のとき" do
          let(:password_confirmation) { nil }
          it { should be_invalid }
        end

        context "パスワードの入力値と一致していないとき" do
          let(:password_confirmation) { "PAssword1" }
          it { should be_invalid }
        end
      end
    end
  end

  describe "#skip_password_validation" do
    subject { user.skip_password_validation }
    let(:user) { FactoryBot.build(:user) }
    it { expect(subject).to eq(true) }
  end
end
