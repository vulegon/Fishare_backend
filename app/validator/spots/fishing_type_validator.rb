module Spots
  class FishingTypeValidator < ActiveModel::Validator
    def validate(record)
      unless (record.fishing_types - record.fishing_types_record.pluck(:name)).empty?
        record.errors.add(:fishing_types, "釣りの種類は#{FishingType::NAMES}から選択する必要があります")
      end
    end
  end
end
