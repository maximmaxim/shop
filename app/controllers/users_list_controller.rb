require 'digest/sha1'
class UsersListController < ApplicationController
  def index
  @users_list =User.paginate :page => params[:page], :per_page => 5
  end

  def current_objects
    @current_object ||= User.paginate :page => params[:page], :per_page => 5
  end
   
  def delete_user
  if request.post?
    user =User.find(params[:id])
    user.destroy
  end
  redirect_to(:action=>:users_list)  
end

 def after_destroy
 if User.count.zero?
    raise "Последнего шмузверя не трожььь!!!"
 end
 end
  

end
