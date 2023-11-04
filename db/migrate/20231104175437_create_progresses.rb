class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :target_user, foreign_key: { to_table: :users }, index: { name: 'index_progresses_on_target_user_id' }
      t.float :percentage

      t.timestamps
    end
  end
end
