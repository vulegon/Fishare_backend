FactoryBot.define do
  factory :fish do
    name { "#{Fish::NAMES.sample}" }
  end
end
