FactoryBot.define do
  factory :user do
    name { "user" }
    password { "password1" }
    email { "user@example.com" }
  end
end
