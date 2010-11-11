class StoreController < ApplicationController
  layout "all"
  def index
  @store ||= Product.paginate :page => params[:page], :per_page => 3
  end
  
  def clothes
  @store ||= Product.paginate :page => params[:page], :per_page => 6
  end

  def menu
  @time=Time.now
  end

  def save_order
   @cart=find_cart
   @order=Order.new(params[:order])
   @order.add_line_items_from_cart(@cart)
   if @order.save
      @item=LineItem.find_all_by_order_id(@order.id)
     Notifier.deliver_user_confirmation(@order,@item)
     session[:cart] = nil
     redirect_to :action=> :menu
	 flash[:notice] = "Спасибо за Ваш заказ!"
   else
     render :action=>:checkout
   end
  end


   #before_filter :authorize, :except=> :index 
  def add_to_cart
  begin
    product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error("Товар не существует!!! #{params[:id]} ")
  flash[:notice] = "Неверный идентификатор товара"
  redirect_to :action=>:menu
  else
  @cart = find_cart
  @cart.add_product(product)
  
  end
  end

  def remove_from_cart
  @cart = find_cart
 # else
  product = Product.find(params[:id])	
  @cart.remove_item(product)
  #end
  if @cart.items.empty?
       redirect_to :action =>:menu
	flash[:notice] = "Ваша корзина пуста"
  end
  end

  def empty_cart
  session[:cart] = nil
  flash[:notice] = "Ваша корзина пуста"
  redirect_to :action=>:menu
  end

  def checkout
   @cart=find_cart 
   if @cart.items.empty?
       redirect_to :action =>:menu
	flash[:notice] = "Ваша корзина пуста"
   else 
      @order = Order.new
   end
   
  end

  private 
	def find_cart
	    session[:cart] ||=Cart.new  	
	end

end
