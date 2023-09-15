require 'rails_helper'

RSpec.describe FeaturedBlogPostPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:featured_published_post) { build(:featured_blog_post, :with_published_post) }

  permissions :create?, :update?, :destroy? do
    it 'denies permission for a regular user' do
      expect(subject).not_to permit(user, featured_published_post)
    end

    it 'grants permission for an admin' do
      expect(subject).to permit(admin, featured_published_post)
    end
  end

  permissions :index? do
    it 'grants permission to a nil user' do
      expect(subject).to permit(nil, featured_published_post)
    end
  end
end
