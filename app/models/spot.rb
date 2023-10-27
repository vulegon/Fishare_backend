class Spot < ApplicationRecord
  # 釣り場のモデル
  LATITUDE_RANGE = -90..90
  LONGITUDE_RANGE = -180..180
  NAME_MAXIMUM_LIMIT = 300
  DESCRIPTION_MAXIMUM_LIMIT = 1000

  belongs_to :user
  belongs_to :location
  has_many_attached :images
  has_many :spot_fishing_types
  has_many :fishing_types, :through => :spot_fishing_types, dependent: :destroy
  has_many :catchable_fishes
  has_many :fish, :through => :catchable_fishes, dependent: :destroy

  validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LIMIT }
  validates :description, presence: true, length: { maximum: DESCRIPTION_MAXIMUM_LIMIT }
  validates :latitude, presence: true
  validates :longitude, presence: true

  validate :latitude_within_range
  validate :longitude_within_range

  scope :valid, -> { where(is_deleted: false) }

  # 釣り場に紐づく画像のURLを返します。
  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end

  private

  def latitude_within_range
    unless LATITUDE_RANGE.cover?(latitude)
      errors.add(:latitude, "緯度が#{LATITUDE_RANGE}の範囲内ではありません")
    end
  end

  def longitude_within_range
    unless LONGITUDE_RANGE.cover?(longitude)
      errors.add(:longitude, "経度が#{LONGITUDE_RANGE}の範囲内ではありません")
    end
  end
end
