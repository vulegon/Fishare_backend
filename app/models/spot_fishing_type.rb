class SpotFishingType < ApplicationRecord
  # 釣り場と釣りの種類を紐付ける中間テーブル
  belongs_to :spot
  belongs_to :fishing_type

  scope :valid, -> { where(is_deleted: false) }
end
