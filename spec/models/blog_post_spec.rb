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
  describe '#scopes' do
    describe '.all_featured' do
      let(:post_with_feature) { create(:blog_post) }
      let(:normal_post) { create(:blog_post) }

      before do
        create(:featured_blog_post, blog_post: post_with_feature)
      end

      it 'returns a collection including the featured post' do
        expect(described_class.all_featured).to include(post_with_feature)
      end

      it 'returns a collection not including the normal post' do
        expect(described_class.all_featured).not_to include(normal_post)
      end
    end
  end
end
