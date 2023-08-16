require 'rails_helper'

RSpec.describe BlogPostPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:user_blog_post) { create(:blog_post, user:) }
  let(:random_blog_post) { create(:blog_post) }

  permissions :show?, :create? do
    it 'grants permission to any user' do
      expect(subject).to permit(user, random_blog_post)
    end
  end

  permissions :update?, :destroy? do
    it 'denies permission if the user does not own the post' do
      expect(subject).not_to permit(user, random_blog_post)
    end

    it 'grants permission to the user if they own the post' do
      expect(subject).to permit(user, user_blog_post)
    end
  end
end
