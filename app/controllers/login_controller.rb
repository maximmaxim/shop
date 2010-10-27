class LoginController < ApplicationController
  layout = "admin"
  
  def add_user
  @user = User.new(params[:user])
  if request.post? and @user.save
	flash.now[:notice] = "Пользователь #{@user.name} зарегистрирован"
        @user = User.new
  end
  end

  def login
  session[:user_id] = nil
    if request.post?
	user = User.authenticate(params[:name], params[:password])
	if user
	  session[:user_id] = user.id
	  uri = session[:original_uri]
	  session[:original_uri] = nil
	  if (user.is_admin == "yes")
	  redirect_to(uri || {:controller=>"products", :action => "index"})
	  else 
 	  redirect_to(uri || {:controller=>"store", :action => "index"})
          end 
	else
	  flash[:notice] = "Неправильное сочетание имя-пароль" 
	end
    end 
  end

  def logout
  session[:user_id] = nil
  flash[:notice] = "Вы успешно разлогинились"
  redirect_to (:action=> :login)
  end

end
