class IndexForOAuth < ActiveRecord::Migration
  def self.up
    add_index :users, :twitter_handle, :unique => true
    add_index :users, [:twitter_oauth_token, :twitter_oauth_secret]
  end
end
