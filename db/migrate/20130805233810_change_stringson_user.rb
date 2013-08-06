class ChangeStringsonUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :u_id, :uid
      t.rename :twitter, :provider
    end
  end
end
