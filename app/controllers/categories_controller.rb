class CategoriesController < ApplicationController
  include SessionsHelper

  def new
    @category = Category.new
  end

  def index
    @user = current_user
    @categories = @user.categories
    @categories_container = []

    @categories.each do |category|
      @categories_container.unshift(category)
    end
  end

  def show
      @user = current_user
      @category = find_category
      @blogs = []
      @category.blogs.each do |blog|
        @blogs.unshift(blog)
      end
  end

  def create
    @user = current_user
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to user_categories_path(@user, @category), notice: "category created"}
        format.json { render :show, status: :created, location: @category}
      else
        format.html { redirect_to new_user_categories_path(@user, @category), notice: "category creation failed"}
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @category = find_category
  end

  def update
    @category = find_category

    respond_to do |format|
      if @category && @category.user_id == current_user.id
        @category.update(category_params)
        format.html {redirect_to user_categories_path(@category.user_id, @category), notice: "Category updated"}
        format.json{ render :show, status: :created, location: @category}
      else
        format.html { redirect_to new_user_category_path(@category), notice: "update failed" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_category
    Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :user_id)
  end
end
