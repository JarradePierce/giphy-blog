class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @user = find_user
    @categories = @user.categories
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      format.html { redirect_to @category, notice: "category created"}
      format.json { render :show, status: :created, location: @category}
    else
      format.html { render :new }
      format.json { render json: @category.errors, status: :unprocessable_entity }
  end

  private

  def find_user
    User.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :user_id)
  end
end
