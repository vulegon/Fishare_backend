FactoryBot.define do
  factory :spot do
    name { "釣り場1" }
    description { "説明" }
    latitude { 36.063053704526226 }
    longitude { 136.22288055523217 }
    location_id { FactoryBot.create(:location).id }
    user_id { FactoryBot.create(:user).id }
    is_deleted { false }

    after(:build) do |spot|
      spot.images.attach(
        io: File.open(Rails.root.join("spec", "samples", "images", "ボルメテウス・サファイア・ドラゴン.jpg")),
        filename: "ボルメテウス・サファイア・ドラゴン.jpg",
        content_type: "image/png",
      )

      spot.images.attach(
        io: File.open(Rails.root.join("spec", "samples", "images", "勝利宣言 鬼丸「覇」.jpg")),
        filename: "勝利宣言 鬼丸「覇」.jpg",
        content_type: "image/png",
      )
    end
  end
end
