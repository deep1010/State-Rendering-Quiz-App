class SessionsController < ApplicationController
  skip_before_action :authorize 
  def new
  end

  def create
    session[:user_id]=nil
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      if user.name == "admin"
  		  redirect_to admin_url
      else
        redirect_to "/homepage"
      end
  	else	
  		redirect_to login_url, alert:"Invalid Credentials"
  	end
  end

  def destroy
    if session[:user_id]
      session[:user_id]=nil
      redirect_to login_url, alert:"Logged Out"
    else
      redirect_to login_url, alert: "No User Logged In"
    end
  end
end
