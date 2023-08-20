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
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user
  has_rich_text :content

  has_one :featured_blog_post, dependent: :destroy

  enum status: {
    draft: 0,
    published: 1
  }

  validates :title, presence: true

  scope :order_newest_first, -> { order(created_at: :desc) }

  def slug_candidates
    [
      :title,
      %i[title id]
    ]
  end

  def featured?
    featured_blog_post.present?
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
