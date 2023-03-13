require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    subject { FactoryBot.build(:user, name: name, password: password, email: email) }
    let(:name) { 'テスター1' }
    let(:password) { 'password1' }
    let(:email) { 'example@example.com' }

    context 'name password emailそれぞれが正しいとき' do
      it { expect(subject).to be_valid }
    end

    context 'nameが正しくないとき' do
      context 'nameが空欄のとき' do
        let(:name) {  }
        it { expect(subject).to be_invalid }
      end
    end

    context 'passwordが正しくないとき' do
      context 'passwordの長さが8文字未満のとき' do
        let(:password) { 'passwo1' }
        it { expect(subject).to be_invalid }
      end

      context 'passwordの長さが128文字を超えるとき' do
        let(:password) { 'password1-password1-password1-password1-password1-password1-password1-password1-password1-password1-password1-password1-password1' }
        it { expect(subject).to be_invalid }
      end

      context 'passwordが半角数字のみのとき' do
        let(:password) { '12345678' }
        it { expect(subject).to be_invalid }
      end

      context 'passwordが半角英字のみのとき' do
        let(:password) { 'password' }
        it { expect(subject).to be_invalid }
      end
    end

    context 'emailが正しくないとき' do
      context 'emailが@から始まるとき' do
        let(:password) { '@example.com' }
        it { expect(subject).to be_invalid }
      end

      context 'emailに@が含まれないとき' do
        let(:password) { 'exampleexample.com' }
        it { expect(subject).to be_invalid }
      end

      context 'emailの@以降に.が含まれないとき' do
        let(:password) { 'example@examplecom' }
        it { expect(subject).to be_invalid }
      end

      context 'emailの.以降に英小文字が含まれないとき' do
        let(:password) { 'example@example.' }
        it { expect(subject).to be_invalid }
      end
    end
  end

  describe '#save!' do
    subject { user.save! }
    let(:user) { FactoryBot.build(:user, email: email, password: password) }
    let(:email) { 'example@example.com' }
    let(:password) { 'password1' }

    context 'emailが大文字のとき' do
      let(:email) {'EXAMPLE@EXAMPLE.COM'}
      it '小文字でemailが保存されること' do
        expect{ subject }.to change { User.exists?(email: 'example@example.com') }.from(false).to(true)
      end
    end

    it 'パスワードが暗号化されて保存されること' do
      subject
      expect(user.reload.valid_password?(password)).to be_truthy
    end  
  end
end
