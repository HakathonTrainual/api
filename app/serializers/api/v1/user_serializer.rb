module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :email, :description, :department, :instagram,
                 :facebook, :image_url

      has_many :user_hobbies, serializer: UserHobbySerializer

      def image_url
        object.image.url if object.image.attached?
      end
    end
  end
end
