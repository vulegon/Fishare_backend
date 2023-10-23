FactoryBot.define do
  factory :user do
    name { "test_user1" }
    password { "Password1" }
    password_confirmation { "Password1" }
    email { "user@example.com" }
    skip_password_validation { false }
  end
end
