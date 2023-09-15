# frozen_string_literal: true

class BlogPosts::ListComponent < ViewComponent::Base
  def initialize(blog_posts:, empty_message: '')
    @blog_posts = blog_posts
    @empty_message = empty_message
  end

  private

  attr_reader :blog_posts, :empty_message

  def render_empty_state?
    blog_posts.empty? && empty_message.present?
  end
end
