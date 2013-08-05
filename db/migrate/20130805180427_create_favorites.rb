class CreateFavorites < ActiveRecord::Migration
  def up
    create_table :favorites do |t|
      t.timestamps
    end
  end

  def down
    drop_table :favorites
  end
end
