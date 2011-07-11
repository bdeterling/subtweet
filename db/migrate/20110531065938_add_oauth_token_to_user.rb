class AddOauthTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :token, :string, :limit => 255
    add_column :users, :secret, :string, :limit => 255
  end

  def self.down
    remove_column :users, :token
    remove_column :users, :secret
  end
end
