# app/serializers/api/v1/user_hobby_serializer.rb

module Api
  module V1
    class UserHobbySerializer < ActiveModel::Serializer
      attributes :id, :hobby_id  # Include other attributes as needed
    end
  end
end
