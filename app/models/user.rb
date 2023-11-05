class User < ApplicationRecord
  include Userable

  has_secure_password

  has_many :progresses, dependent: :destroy
  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies
  has_one_attached :image

  enum department: {
    Development: 0,
    Marketing: 1,
    Support: 2,
    Finance: 3,
    Management: 4,
    Design: 5,
    Testing: 6
  }
end
