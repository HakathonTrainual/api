class Progress < ApplicationRecord
  belongs_to :user #, class_name: 'User'
  belongs_to :target_user, class_name: 'User'

  PROGRESS_RANGE = 0..10

  validates :percentage, numericality: { only_integer: true, greater_than_or_equal_to: PROGRESS_RANGE.min, less_than_or_equal_to: PROGRESS_RANGE.max }
end
