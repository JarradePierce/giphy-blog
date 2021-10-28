class AddCompletedToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :completed, :boolean, :default => false
  end
end
