require 'rails_helper'

RSpec.describe Users::Registrations::CreateParameter, type: :parameter do
  describe '#valid' do
    subject { described_class.new(params) }
    let(:params) { ActionController::Parameters.new(email: email) }
    let(:email) { 'example@example.com' }
  
    context 'パラメーターが正しいとき' do
      it { is_expected.to be_valid }
    end

    context 'パラメーターが正しくないとき' do
      context 'メールアドレスが正しくない時' do
        context '既に登録されているメールアドレスのとき' do
          let!(:user) { FactoryBot.create(:user, email: 'example@example.com') }
          it { is_expected.to be_invalid }
        end

        context '正しくないメールアドレスの形式のとき' do
          let(:email) { 'example' }
          it { is_expected.to be_invalid }
        end
      end
    end
  end
end
