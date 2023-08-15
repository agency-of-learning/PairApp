# == Schema Information
#
# Table name: featured_blog_posts
#
#  id           :bigint           not null, primary key
#  row_order    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  blog_post_id :bigint           not null
#
# Indexes
#
#  index_featured_blog_posts_on_blog_post_id  (blog_post_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_post_id => blog_posts.id)
#
class FeaturedBlogPost < ApplicationRecord
  belongs_to :blog_post
end
