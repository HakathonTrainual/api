class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :department, :integer, null: false, default: 0
    add_column :users, :instagram, :string
    add_column :users, :facebook, :string
  end
end
