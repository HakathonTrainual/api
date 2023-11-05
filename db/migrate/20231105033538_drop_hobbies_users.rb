class DropHobbiesUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :hobbies_users
  end
end
