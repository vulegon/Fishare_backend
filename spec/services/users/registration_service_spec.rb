require 'rails_helper'

RSpec.describe Users::RegistrationService do
  describe '.create!' do
    subject { described_class.create!(create_params) }
    let(:create_params) { Users::Registrations::CreateParameter.new(params) }
    let(:params) { ActionController::Parameters.new(name: name, email: email, password: password) }
    let(:name) { 'ユーザー1' }
    let(:password) { 'password1' }
    let(:email) { 'example@example.com' }
  
    it 'ユーザーが作成されること' do
      expect{subject}.to change{User.exists?(name: name,email: email)}.from(false).to(true)
    end
  end
end
