class ChangePercentageDefaultInProgresses < ActiveRecord::Migration[7.0]
  def change
    change_column_default :progresses, :percentage, from: nil, to: 0.0
  end
end
