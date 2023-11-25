module Spots
  class ShowSerializer < ActiveModel::Serializer
    attributes :id, :name, :latitude, :longitude, :description, :location, :fish, :fishing_types, :images, :editable

    def initialize(object, user)
      super(object)
      @user = user
    end

    def location
      object.location.name
    end

    def fish
      object.fish.pluck(:name)
    end

    def fishing_types
      object.fishing_types.pluck(:name)
    end

    def images
      object.image_urls
    end

    def editable
      object.editable?(@user)
    end
  end
end
