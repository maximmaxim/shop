class AddUserIsAdmin < ActiveRecord::Migration
  def self.up
  add_column :users, :is_admin, :bit
  end

  def self.down
  remove_column :users, :is_admin
  end
end
