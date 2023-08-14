# == Schema Information
#
# Table name: featured_blog_posts
#
#  id           :bigint           not null, primary key
#  order        :integer
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
require 'rails_helper'

RSpec.describe FeaturedBlogPost do
  pending "add some examples to (or delete) #{__FILE__}"
end
