class AddOrdersDone < ActiveRecord::Migration
  def self.up
  add_column :orders, :done, :string, :default=>'No'
  end

  def self.down
  remove_column :orders, :done
  end
end
