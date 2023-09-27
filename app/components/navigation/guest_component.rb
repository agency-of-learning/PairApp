# frozen_string_literal: true

class Navigation::GuestComponent < NavigationComponent
  private

  def home_path
    root_path
  end

  def primary_links
    [
      { text: 'Agency Blog', path: featured_blog_posts_path },
      { text: 'FAQ', path: faq_path }
    ]
  end

  def dropdown_links
    []
  end
end
