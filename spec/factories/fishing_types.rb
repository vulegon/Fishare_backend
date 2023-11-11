FactoryBot.define do
  factory :fishing_type do
    name { "#{FishingType::NAMES.sample}" }
  end
end
