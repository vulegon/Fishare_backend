require 'rails_helper'

RSpec.describe Users::Registrations::CreateParameter, type: :parameter do
  describe '#valid' do
    subject { described_class.new(params) }
    let(:params) { ActionController::Parameters.new(name: name, email: email, password: password) }
    let(:name) { 'ユーザー1' }
    let(:password) { 'password1' }
    let(:email) { 'example@example.com' }
  
    context 'パラメーターが正しいとき' do
      it { expect(subject).to be_valid }
    end

    context 'パラメーターが正しくないとき' do
      context '名前が正しくないとき' do
        context '名前が空欄のとき' do
          let(:name) { '' }
          it { expect(subject).to be_invalid }
        end

        context '名前の長さが20文字超えるとき' do
          let(:name) { '123456789-123456789-1' }
          it { expect(subject).to be_invalid }
        end
      end

      context 'メールアドレスが正しくない時' do
        context 'メールアドレスが空欄のとき' do
          let(:email) { '' }
          it { expect(subject).to be_invalid }
        end

        context '既に登録されているメールアドレスのとき' do
          let!(:user) { FactoryBot.create(:user, email: 'example@example.com') }
          it { expect(subject).to be_invalid }
        end

        context 'メールアドレスのフォーマットが正しくないとき' do
          let(:password) { 'user@example.' }
          it { expect(subject).to be_invalid }
        end
      end

      context 'パスワードが正しくないとき' do
        context 'パスワードが空欄のとき' do
          let(:password) { '' }
          it { expect(subject).to be_invalid }
        end

        context 'パスワードの長さが8文字未満のとき' do
          let(:password) { 'abcdef1' }
          it { expect(subject).to be_invalid }
        end

        context 'パスワードの長さが128文字超えるとき' do
          let(:password) { '123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-abcdefghi' }
          it { expect(subject).to be_invalid }
        end

        context 'パスワードのフォーマットが正しくないとき' do
          let(:password) { 'password' }
          it { expect(subject).to be_invalid }
        end
      end
    end
  end
end
