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
require 'rails_helper'

RSpec.describe BlogPost do
  describe '#featured?' do
    context 'when the blog post has an associated featured post' do
      let(:blog_post_with_feature) { build(:blog_post, :with_feature) }

      it 'returns true' do
        expect(blog_post_with_feature).to be_featured
      end
    end

    context 'when the blog post lacks an associated featured post' do
      let(:blog_post) { build(:blog_post) }

      it 'returns false' do
        expect(blog_post).not_to be_featured
      end
    end
  end

  describe '#friendly_id' do
    let(:blog_post) { create(:blog_post, title: 'Blog Post') }

    context 'when the blog post title changes' do
      it 'the slug changes to match the new title' do
        expect {
          blog_post.update(title: 'Different Name')
        }.to change(blog_post, :slug).from('blog-post').to('different-name')
      end
    end
  end
end
