class CreatePoems < ActiveRecord::Migration
  def up
    create_table :poems do |t|
      t.text :text
      t.string :source_user
      t.timestamps
    end
  end

  def down
    drop_table :poems
  end
end
