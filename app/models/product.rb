class Product < ActiveRecord::Base
 has_many :line_items
 has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => 'rails.png'

validates_presence_of :name, :quontity, :price

validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif'],  :message => "Oops! Точно картинку загружаешь?"

def self.find_products_for_sale
find(:all, :order=>"name")
end

end
