module Spots
  module Show
    class ImageSerializer < ActiveModel::Serializer
      attributes :id, :filename, :content_type, :img

      def img
        Rails.application.routes.url_helpers.rails_blob_url(object)
      end
    end
  end
end
