class ProductsController < ApplicationController
before_filter :authorize_admin, :except=> :login 

make_resourceful do
       build :all 
      before :index do
       @total_orders= Order.count
      end   
    end


  def current_objects
    @current_objects ||= Product.paginate :page => params[:page], :per_page => 5
  end

end
