class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.text :bio
      t.string :url
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
