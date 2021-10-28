module BlogsHelper

  def reverse_blog_order(blogs)
    @user = current_user
    @blogs_container = []

    @blogs.each do |blog|
      @blogs_container.unshift(blog)
    end
  end

  def points_hash
    @pointsHash = {
      none: 0,
      easy: 10,
      medium: 20,
      hard: 30
    }
  end

  def categories_hash(hash)
    @userCategories = current_user.categories

    @userCategories.each do |category|
      @categoriesHash[category.title] = category.id
    end
  end

end
