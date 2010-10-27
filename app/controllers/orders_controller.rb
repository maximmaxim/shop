class OrdersController < ApplicationController
#make_resourceful do
  #     build :all 
    # before :index do
    
	def index
     @orders=Order.find(:all)
     @items=LineItem.find(:all)   
   #@items= LineItem.find(params[:order_id])      
  end   

def destroy
    @order = Order.find(params[:id])
    # @items=LineItem.find_by_order_id(params[:id])
    @order.destroy
    redirect_to(:action=>"index")
	#@item.destroy
	#respond_to do |format|
      #format.html { redirect_to(orders_url) }
     # format.xml  { head :ok }
    # end 
end

end
