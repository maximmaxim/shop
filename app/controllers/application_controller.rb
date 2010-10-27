# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '36e13d58bb0b15d1aadd9e831649cdd5'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  private 
	def authorize
	  unless User.find_by_id(session[:user_id])
	  flash[:notice] = "Пожалуйста пройдите авторизацию"
	  redirect_to(:controller => "login", :action=> "login" )
	  end
	end


	def authorize_admin
	user = User.find_by_id(session[:user_id])	  
	unless (User.find_by_id(session[:user_id]) )&&(user.is_admin == "yes" )
	  flash[:notice] = "Пожалуйста пройдите авторизацию"
	  redirect_to(:controller => "login", :action=> "login" )
	  end
        end

end
