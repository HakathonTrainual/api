class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :target_user
end
