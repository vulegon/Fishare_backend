FactoryBot.define do
  factory :spot do
    latitude { 36.15305354356379 }
    longitude { 136.2725972414738 }
    user_id { 'cognito_user' }
    description { "適当な説明文" }

    trait :with_images do
      after(:build) do |spot|
        spot.images.attach(io: File.open(Rails.root.join("spec", "samples", "images", "ボルメテウス・サファイア・ドラゴン.jpg")),
                           filename: "ボルメテウス・サファイア・ドラゴン.jpg", content_type: "image/jpeg")

        spot.images.attach(io: File.open(Rails.root.join("spec", "samples", "images", "勝利宣言 鬼丸「覇」.jpg")),
                           filename: "勝利宣言 鬼丸「覇」.jpg", content_type: "image/jpeg")
      end
    end
  end
end
