class CatchableFish < ApplicationRecord
  # 釣り場と釣れる魚を紐付ける中間テーブル
  belongs_to :spot
  belongs_to :fish

  scope :valid, -> { where(is_deleted: false) }
end
