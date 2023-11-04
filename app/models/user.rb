class User < ApplicationRecord
  has_secure_password
  has_many :progresses
  has_one_attached :image
end
