class AddUserMail < ActiveRecord::Migration
  def self.up
  add_column :users, :mail, :text
  end

  def self.down
  remove_column :users, :mail
  end
end
