class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to @user
    else
      flash[:notice] = "Login failed"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end

  private

  def set_user
    @user= User.find(params[:id])
  end

  def user_params
    params.require(:session).permit(:email, :password)
  end
end