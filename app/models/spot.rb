class Spot < ApplicationRecord
  has_many_attached :images
  validates :latitude, presence: true
  validates :longitude, presence: true
end
