require "rails_helper"

RSpec.describe Users::RegistrationService, type: :service do
  describe ".create_user!" do
    subject { described_class.create_user!(create_params) }
    let(:create_params) { ::Users::Registrations::CreateParameter.new(params) }
    let(:params) { ActionController::Parameters.new(email: email) }
    let(:email) { "example@example.com" }

    before(:each) do
      allow(UserMailer).to receive(:registration_confirmation).and_return(double("mail", deliver: true))
    end

    context "メール認証していないユーザーが作成されていること。メールが送られるメソッドが実行されていること" do
      it {
        expect(UserMailer).to receive(:registration_confirmation)
        expect { subject }.to change { User.exists?(email: email) }.from(false).to(true)
      }
    end
  end
end
