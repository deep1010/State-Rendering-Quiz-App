class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create, :index]
  
  def index
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @users = User.all
    else
      redirect_to "/422"
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: 'User was successfully created.Please Login Now' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      if @user.name !="admin"
        if @a=Attempt.where(:uname => @user.name)
          @a.destroy_all
        end
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
        redirect_to users_url, notice: "Cannot destroy admin account"
      end
    else
      redirect_to "/422"
    end
  end
  
  
  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
