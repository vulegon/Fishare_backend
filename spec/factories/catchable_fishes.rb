FactoryBot.define do
  factory :catchable_fish do
    spot_id { FactoryBot.create(:spot).id }
    fish_id { FactoryBot.create(:fish).id }
    is_deleted { false }
  end
end
