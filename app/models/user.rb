class User < ApplicationRecord
  include Userable

  has_secure_password

  has_many :progresses
  has_one_attached :image
  has_and_belongs_to_many :hobbies
end
