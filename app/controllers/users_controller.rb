class UsersController < ApplicationController
  include SessionsHelper
  include GiphysHelper

  def show
    @user = find_user
    @blogs = []
    @user.blogs.each do |blog|
      @blogs.unshift(blog)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

      if @user.valid? && User.count < 1
      respond_to do |format|
        if @user.save
          @defaultCategory = @user.categories.create(title: 'default', user_id: @user.id)
          session[:id] = @user.id
          format.html { redirect_to @user, notice: "#{@user.username}'s' new account created" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
