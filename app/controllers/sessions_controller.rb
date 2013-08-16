class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.password == params[:user][:password]
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] ||= []
      flash[:errors] << "Login failed."
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
