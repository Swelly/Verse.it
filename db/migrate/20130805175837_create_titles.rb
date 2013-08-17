class CreateTitles < ActiveRecord::Migration
  def up
    create_table :titles do |t|
      t.string :title
      t.string :image
      t.timestamps
    end
  end

  def down
    drop_table :titles
  end
end
