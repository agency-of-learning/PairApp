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

  permissions :feature? do
    let(:admin) { create(:user, :admin) }
    let(:published_post) { build(:blog_post, status: :published) }
    let(:featured_published_post) { build(:blog_post, :with_feature, status: :published) }

    context 'when the post is published' do
      it 'denies permission to a visitor' do
        expect(subject).not_to permit(nil, published_post)
      end

      it 'denies permission for member users' do
        expect(subject).not_to permit(user, published_post)
      end

      it 'grants permission for admin users' do
        expect(subject).to permit(admin, published_post)
      end
    end

    context "when the post isn't published" do
      it 'denies permission for admin users' do
        expect(subject).not_to permit(user, random_blog_post)
      end
    end

    context 'when the post is already featured' do
      it 'denies permission for admin users' do
        expect(subject).not_to permit(user, featured_published_post)
      end
    end
  end
end
