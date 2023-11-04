class CreateJoinTableUsersHobbies < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :hobbies do |t|
      t.index %i[user_id hobby_id]
      t.index %i[hobby_id user_id]
    end
  end
end
