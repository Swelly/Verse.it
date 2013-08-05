class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :u_id, :string
    add_column :users, :u_name, :string
  end
end
