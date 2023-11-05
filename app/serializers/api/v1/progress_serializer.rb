class Api::V1::ProgressSerializer < ActiveModel::Serializer
  attributes :target_user_id, :percentage
end
