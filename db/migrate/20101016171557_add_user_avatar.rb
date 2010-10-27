class AddUserAvatar < ActiveRecord::Migration
  def self.up
  add_column :users, :avatar, :text
  end

  def self.down
  remove_column :users, :avatar
  end
end
