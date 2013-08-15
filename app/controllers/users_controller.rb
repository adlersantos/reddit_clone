class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] ||= []
      flash[:errors] << "Sign up failed."
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end
end
