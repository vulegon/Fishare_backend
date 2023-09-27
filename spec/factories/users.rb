FactoryBot.define do
  factory :user do
    name { "test_user1" }
    password { "password1" }
    email { "user@example.com" }
  end
end
