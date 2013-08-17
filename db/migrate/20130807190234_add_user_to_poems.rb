class AddUserToPoems < ActiveRecord::Migration
  def change
    add_column :poems, :user_id, :integer
  end
end
