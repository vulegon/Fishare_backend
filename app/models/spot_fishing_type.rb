class SpotFishingType < ApplicationRecord
  belongs_to :spot
  belongs_to :fishing_type

  scope :valid, -> { where(is_deleted: false) }
end
