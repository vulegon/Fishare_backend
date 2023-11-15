ActiveRecord::Base.transaction do
  (1..10).each_with_index do |user, i|
    name = "tester#{i}"
    password = "Password#{1}"
    password_confirmation = password
    email = "example#{i}@example.com"
    User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation)
  end
end

fish = Fish::NAMES.map { |fish_name| Fish.new(name: fish_name) }
Fish.import fish

fishing_types = FishingType::NAMES.map { |fishing_type_name| FishingType.new(name: fishing_type_name) }
FishingType.import fishing_types

locations = Location::NAMES.map { |location_name| Location.new(name: location_name) }
Location.import locations

# location, fish, fishing_typesが違うspotのレコードを作成する
location = Location.find_by(name: "海釣り")
user = User.find_by(email: "example0@example.com")
fish_records = Fish.where(name: ["カサゴ","タイ","キス"])
fishing_types_records = FishingType.where(name: ["穴釣り","サビキ釣り"])
positions = [
  { latitude: 35.67207035801073, longitude: 139.95301662060612 }, #市川漁港
  { latitude: 35.67152230520766, longitude: 139.95860167986368 }, #船橋海浜公園
  { latitude: 35.14184474166084, longitude: 139.6376359462738 }, #宮川漁港
]
ActiveRecord::Base.transaction do
  (1..3).each_with_index do |user, i|
    name = "釣り場テスト#{i}"
    description = "釣り場説明#{i}"
    location_id = location.id
    latitude = positions[i][:latitude]
    longitude = positions[i][:longitude]
    user_id = User.find_by(email: "example#{i}@example.com").id
    spot = Spot.create!(name: name,latitude: latitude, longitude: longitude, description: description, location_id: location_id, user_id: user_id)

    fish_records.each do |fish|
      spot.catchable_fishes.create!(fish_id: fish.id)
    end
  
    fishing_types_records.each do |fifishing_type|
      spot.spot_fishing_types.create!(fishing_type_id: fifishing_type.id)
    end
  end
end


