class CreateTwitterusers < ActiveRecord::Migration
  def up
    create_table :twitterusers do |t|
      t.string :screen_name
      t.timestamps
    end
  end

  def down
    drop_table :twitterusers
  end
end
