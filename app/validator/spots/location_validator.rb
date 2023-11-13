module Spots
  class LocationValidator < ActiveModel::Validator
    def validate(record)
      if record.location_record.blank?
        record.errors.add(:location, "釣り場は#{Location::NAMES}から選択する必要があります")
      end
    end
  end
end
