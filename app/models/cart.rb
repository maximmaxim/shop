class Cart
	attr_reader :items
	
		def initialize
		    @items = []
		end
		
		def add_product(product)
		current_item = @items.find{|item| item.product == product}		 
		if current_item
		 current_item.increment_quantity
		 else
		 @items << CartItem.new(product)		    
		 end
			
		end

		def remove_item(product)	
		current_item = @items.find{|item| item.product == product}			
			
		if (current_item.quantity <= 1)
			@items.delete_if { |item| item.product == product }
		  	 else		
		  	 current_item.decrement_quantity
			end
		end
end

