class CatchableFish < ApplicationRecord
  belongs_to :spot
  belongs_to :fish

  scope :valid, -> { where(is_deleted: false) }
end
