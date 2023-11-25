module Spots
  class IndexSerializer < ActiveModel::Serializer
    attribute :id
    attribute :latitude
    attribute :longitude
  end
end
