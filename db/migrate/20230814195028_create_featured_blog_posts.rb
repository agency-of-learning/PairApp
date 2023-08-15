class CreateFeaturedBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :featured_blog_posts do |t|
      t.references :blog_post, null: false, foreign_key: true
      t.integer :row_order

      t.timestamps
    end
  end
end
