# == Schema Information
#
# Table name: blog_posts
#
#  id         :bigint           not null, primary key
#  slug       :string
#  status     :integer          default(0), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_blog_posts_on_slug     (slug) UNIQUE
#  index_blog_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe BlogPost do
  pending "add some examples to (or delete) #{__FILE__}"
end
