module BlogsHelper

  def reverse_blog_order(blogs)
    @user = current_user
    @blogs_container = []

    @blogs.each do |blog|
      @blogs_container.unshift(blog)
    end
  end

end
