class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :phone, :string, null: false, limit: 15
    add_column :users, :address, :string, null: false
  end
end
