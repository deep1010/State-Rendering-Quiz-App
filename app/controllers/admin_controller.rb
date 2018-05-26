class AdminController < ApplicationController
  def index
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
  
    else
      redirect_to "/422"
    end
  end
end