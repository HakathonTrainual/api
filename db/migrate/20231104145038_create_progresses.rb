class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :target_user, null: false, foreign_key: true
      t.float :percentage

      t.timestamps
    end
  end
end
