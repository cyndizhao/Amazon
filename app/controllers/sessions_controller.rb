class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged In!"
      redirect_to root_path
    else
      flash[:alert] = "Could not Log In!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out!"
    redirect_to new_session_path
  end
end
