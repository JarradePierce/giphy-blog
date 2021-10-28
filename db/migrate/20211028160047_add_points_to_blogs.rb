class AddPointsToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :points, :integer, :default => 0
  end
end
