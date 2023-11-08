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
