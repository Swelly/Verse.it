class AddTwitterTokens < ActiveRecord::Migration
  def change
    add_column :users, :twitter_handle, :string
    add_column :users, :twitter_oauth_token, :string
    add_column :users, :twitter_oauth_secret, :string
  end
end
