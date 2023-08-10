class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :slug

      t.timestamps
    end
    add_index :blog_posts, :slug, unique: true
  end
end
