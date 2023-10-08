class Location < ApplicationRecord
  # 釣り場の種類
  has_one :spot
  NAMES = ["海釣り","川釣り"]
end
