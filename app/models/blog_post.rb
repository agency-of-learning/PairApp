# == Schema Information
#
# Table name: blog_posts
#
#  id         :bigint           not null, primary key
#  slug       :string
#  status     :integer          default("draft"), not null
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
class BlogPost < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  enum status: {
    draft: 0,
    published: 1
  }

  validates :title, presence: true

  scope :order_newest_first, -> { order(created_at: :desc) }
end
