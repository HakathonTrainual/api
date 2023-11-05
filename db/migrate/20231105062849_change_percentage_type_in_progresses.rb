class ChangePercentageTypeInProgresses < ActiveRecord::Migration[7.0]
  def change
    change_column :progresses, :percentage, :integer, default: 0 # Змінити тип на integer та встановити значення за замовчуванням на 0
  end
end
