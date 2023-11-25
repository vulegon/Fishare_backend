module Spots
  class IndexSerializer < ActiveModel::Serializer
    attribute :id, :latitude, :longitude
  end
end
