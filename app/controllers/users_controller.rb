class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session[:user_id] = @user.id  #create a session to login and logout
      flash[:notice] = "User created and Signed in"
      redirect_to products_path
      # , notice: "User created"
    else
      flash[:alert] = "Something went wrong!"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
