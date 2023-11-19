class Location < ApplicationRecord
  # 釣り場の種類を表すモデル
  # 現状は海釣りと川釣りのみ。
  has_one :spot
  NAMES = ["海釣り","川釣り"]

  validates :name, uniqueness: true, presence: true, inclusion: { in: NAMES, message: "釣り場の種類の名前は#{NAMES.join(', ')}である必要があります" }
end
