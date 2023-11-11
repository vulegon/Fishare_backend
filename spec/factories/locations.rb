FactoryBot.define do
  factory :location do
    name { "#{Location::NAMES.sample}" }
  end
end
