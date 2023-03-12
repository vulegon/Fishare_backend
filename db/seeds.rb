positions = [
  {latitude: 36.20127926543816, longitude: 136.12792391726268},
  {latitude: 35.62157403594883, longitude: 140.05411136023233},
  {latitude: 36.04049680286872, longitude: 140.37267630908482},
  {latitude: 35.72085365236546, longitude: 139.92741562402446},
]

Spot.create!(positions)

(1..10).each_with_index do |user, i|
  name = "tester#{i}"
  password = "password#{1}"
  email = "example#{i}@example.com"
  User.create!(name: name, password: password, email: email)
end
