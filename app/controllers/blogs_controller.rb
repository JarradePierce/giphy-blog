class BlogsController < ApplicationController
  include GiphysHelper
  include SessionsHelper
  include BlogsHelper

  def index
    @blogs = Blog.all
    @blogs_container = []

    # display notes from newest to oldest
    reverse_blog_order(@blogs)
  end

  def new
    @user = current_user
    @blog = Blog.new
    @points_hash = points_hash

    @userCategories = current_user.categories
    @categoriesHash = Hash.new

    @userCategories.each do |category|
      @categoriesHash[category.title] = category.id
    end
  end

  def create
    @user = current_user
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to user_blog_path(@user, @blog), notice: "created new blog" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to user_path(@user), notice: "failed to create blog" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @blog = find_blog
    @giphys = find_giphy(@blog)
  end

  def edit
    @blog = find_blog
    @points_hash = points_hash
    @userCategories = current_user.categories
    @categoriesHash = Hash.new

    @userCategories.each do |category|
      @categoriesHash[category.title] = category.id
    end
  end

  def update
    @blog = find_blog
    @user = current_user

    respond_to do |format|
      if @blog && @blog.user_id == current_user.id
        @blog.update(blog_params)
        if @blog.completed == true
          updatedPoints = @user.points += @blog.points
          @user.update(points: updatedPoints)
          @blog.update(points: 0)
        end
        format.html { redirect_to user_blog_path(@blog.user_id, @blog), notice: "Blog updated" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to user_blog_path(@blog), notice: "update failed" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_points
    @user.points += @blog.points
  end

  def destroy
    @blog = find_blog
    @user = @blog.user

    if @blog && @user.id == current_user.id
      @blog.destroy!
      redirect_to user_path(@user)
    else
      # format.html { redirect_to user_path(@user), notice: "Blog failed to delete" }
      # format.json { render json: @blog.errors, status: :unprocessable_entity }
      redirect_to "users#show"
    end
  end



  private

  def blog_params
    params.require(:blog).permit(:title, :body, :user_id, :category_id, :points, :completed)
  end

  def find_blog
    Blog.find(params[:id])
  end

end
