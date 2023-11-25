module Spots
  class IndexSerializer < ActiveModel::Serializer
    attributes :id, :latitude, :longitude
  end
end
