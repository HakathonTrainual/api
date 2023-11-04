class AddDescriptionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :description, :text, null: true, default: nil
  end
end
