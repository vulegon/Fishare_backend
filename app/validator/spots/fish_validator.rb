module Spots
  class FishValidator < ActiveModel::Validator
    def validate(record)
      unless (record.fish - record.fish_record.pluck(:name)).empty?
        record.errors.add(:fish, "釣れる魚がデータベースに存在しない魚です")
      end
    end
  end
end
