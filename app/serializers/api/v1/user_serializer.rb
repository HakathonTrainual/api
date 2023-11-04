module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :image_url

      def image_url
        object.image.url if object.image.attached?
      end
    end
  end
end
