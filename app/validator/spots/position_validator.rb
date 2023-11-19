module Spots
  class PositionValidator < ActiveModel::Validator
    def validate(record)
      unless ::Spot::LATITUDE_RANGE.include?(record.latitude)
        record.errors.add(:latitude, "緯度は-90°〜+90°の間である必要があります")
      end

      unless ::Spot::LONGITUDE_RANGE.include?(record.longitude)
        record.errors.add(:longitude, "経度は-180°〜+180°の間である必要があります")
      end
    end
  end
end
