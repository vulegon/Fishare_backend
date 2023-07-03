require 'rails_helper'

RSpec.describe Users::Registrations::CreateParameter, type: :parameter do
  describe '#valid' do
    subject { described_class.new(params) }
    let(:params) { ActionController::Parameters.new(email: email) }
    let(:email) { 'example@example.com' }
  
    context 'パラメーターが正しいとき' do
      it { expect(subject).to be_valid }
    end

    context 'パラメーターが正しくないとき' do
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
          let(:email) { 'user@example.' }
          it { expect(subject).to be_invalid }
        end
      end
    end
  end
end
