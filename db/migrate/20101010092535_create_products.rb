class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :model_of_name
      t.decimal :size, :precision=>4, :default=>0
      t.decimal :quontity, :precision=> 5, :default=>0
      t.decimal :price, :precision=> 7, :scale=>2, :default=>0
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
