class CreateUserHobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_hobbies do |t|
      t.references :user, foreign_key: true
      t.references :hobby, foreign_key: true

      t.timestamps
    end
  end
end
