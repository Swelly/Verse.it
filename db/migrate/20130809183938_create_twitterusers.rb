class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitterusers do |t|
      t.string :screen_name

      t.timestamps
    end
  end
end
