class OrdersController < ApplicationController
    
 def index
     @orders=Order.find(:all)
     @items=LineItem.find(:all) 
 end   

 def product_decrement
    order = Order.find(params[:id])
    @items=LineItem.find(:all)    
     for item in @items
      if (item.order_id == order.id)
         product=Product.find(item.product_id)
         product.quontity = product.quontity-item.quantity 
         product.update_attributes(params[:product])
      end
    end
    order.done='Yes'
    order.update_attributes(params[:order])
    redirect_to :action=>'index'
 end


end
