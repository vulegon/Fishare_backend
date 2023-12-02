module Spots
  module Show
    class ShowSerializer < ActiveModel::Serializer
      attributes :id, :name, :latitude, :longitude, :description, :location, :fish, :fishing_types, :images, :editable
      attr_reader :user

      def initialize(object, options = {})
        super(object)
        @user = options[:user]
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
        sorted_images = object.images.blobs.order(created_at: :desc, id: :asc)
        ActiveModelSerializers::SerializableResource.new(sorted_images, each_serializer: ::Spots::Show::ImageSerializer).as_json
      end

      def editable
        object.editable?(user)
      end
    end
  end
end
