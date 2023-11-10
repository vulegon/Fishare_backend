class FishingType < ApplicationRecord
  # 釣りの種類を格納するモデル
  has_many :spot_fishing_types
  has_many :spots, through: :spot_fishing_types
  NAMES = [
    "サビキ釣り",
    "穴釣り",
    "投げ釣り",
    "渓流釣り",
    "ルアー釣り",
    "バス釣り",
  ]
  validates :name, uniqueness: true, presence: true, inclusion: { in: NAMES, message: "釣りの種類の名前は#{NAMES.join(', ')}である必要があります" }
end
