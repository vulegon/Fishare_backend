FactoryBot.define do
  factory :spot do
    name { "釣り場1" }
    latitude { 36.063053704526226 }
    longitude { 136.22288055523217 }
    location_id { FactoryBot.create(:location).id }
  end
end
