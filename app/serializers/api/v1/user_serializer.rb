module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :email, :description, :department, :instagram,
                 :facebook, :image_url, :hobby_names

      def image_url
        object.image.url if object.image.attached?
      end

      def hobby_names
        object.user_hobbies.includes(:hobby).map { |user_hobby| user_hobby.hobby.name }
      end

      def meta
        { user_hobbies: nil }  # Exclude user_hobbies from direct serialization
      end
    end
  end
end
