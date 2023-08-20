FactoryBot.define do
  factory :spot do
    latitude { 36.15305354356379 }
    longitude { 136.2725972414738 }
    user_id { 'cognito_user' }
  end
end
