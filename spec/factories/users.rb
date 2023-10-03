FactoryBot.define do
  factory :user do
    name { "test_user1" }
    password { "Password1" }
    email { "user@example.com" }
  end
end
