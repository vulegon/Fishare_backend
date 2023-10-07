class Spot < ApplicationRecord
  # 釣り場のモデル
  LATITUDE_RANGE = -90..90
  LONGITUDE_RANGE = -180..180
  belongs_to :user
  belongs_to :location
  has_many_attached :images

  validates :latitude, presence: true
  validates :longitude, presence: true

  # 釣り場に紐づく画像のURLを返します。
  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end
end
