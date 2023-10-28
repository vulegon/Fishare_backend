class CatchableFish < ApplicationRecord
  # 釣り場と魚を紐付ける中間テーブル
  belongs_to :spot
  belongs_to :fish
end
