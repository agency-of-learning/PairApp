# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPosts::ListComponent, type: :component do
  let(:empty_posts) { BlogPost.none }
  let(:empty_message) { 'Empty List' }
  let(:blog_posts) { create_list(:blog_post, 3, title: 'Test Post') }

  context 'when the blog posts collection is empty and there is an empty message' do
    it 'renders the empty message' do
      render_inline(described_class.new(blog_posts: empty_posts, empty_message:))

      expect(page).to have_content(empty_message)
    end
  end

  context 'when the blog posts collection contains posts' do
    it 'does not render the empty message' do
      render_inline(described_class.new(blog_posts:, empty_message:))

      expect(page).not_to have_content(empty_message)
    end

    it 'renders the blog posts' do
      render_inline(described_class.new(blog_posts:, empty_message:))

      expect(page).to have_content('Test Post', count: 3)
    end
  end
end
