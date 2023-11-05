class Api::V1::HobbySerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_many :users
end
