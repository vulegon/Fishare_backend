FactoryBot.define do
  factory :spot_fishing_type do
    spot_id { FactoryBot.create(:spot).id }
    fishing_type_id { FactoryBot.create(:fishing_type).id }
  end
end
