class BlogsController < ApplicationController
  include GiphysHelper
  include SessionsHelper

  def index
    @blogs = Blog.all
  end

  def new
    @user = current_user.id
    @blog = Blog.new
  end

  def create
    @user = current_user.id
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to user_path(@user), notice: "created new blog" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to user_path(@user), notice: "failed to create blog" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @blog = find_blog
    @giphys = find_giphy
  end

  def edit
    @blog = find_blog
  end

  def update
    @blog = find_blog

    respond_to do |format|
      if @blog && @blog.user_id == current_user.id
        @blog.update(blog_params)
        format.html { redirect_to user_blog_path(@blog.user_id, @blog), notice: "Blog updated" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to user_blog_path(@blog), notice: "update failed" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
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
    params.require(:blog).permit(:title, :body, :user_id)
  end

  def find_blog
    Blog.find(params[:id])
  end

  def find_giphy
    @giphy_blog = find_blog
    searched_gif = search_gif(@giphy_blog.title)
    @giphy = parse_giphy(searched_gif)
  end

end