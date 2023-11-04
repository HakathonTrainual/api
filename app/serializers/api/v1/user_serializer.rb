module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :email, :description, :department, :instagram,
                 :facebook
    end
  end
end
