class AddUsersAndTitles < ActiveRecord::Migration
  def up
    create_table :titles_users do |t|
      t.belongs_to :title
      t.belongs_to :user
    end
  end

  def down
    drop_table :titles_users
  end
end
