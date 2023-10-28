class Location < ApplicationRecord
  # 釣り場の種類を表すモデル
  # 現状は海釣りと川釣りのみ。
  has_one :spot
  NAMES = ["海釣り","川釣り"]
end
