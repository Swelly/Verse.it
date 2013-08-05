class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :twitter_handle
      t.string :name
      t.text :bio
      t.string :email
      t.string :url
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
