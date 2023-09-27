# frozen_string_literal: true

class Navigation::ApplicantComponent < NavigationComponent
  private

  def home_path
    user_mentee_applications_path
  end

  def primary_links
    [
      { text: 'My Applications', path: user_mentee_applications_path },
      { text: 'Agency Blog', path: featured_blog_posts_path },
      { text: 'FAQ', path: faq_path }
    ]
  end

  def dropdown_links
    [
      { text: 'Account Settings', path: edit_user_registration_path },
      { text: 'Logout', path: destroy_user_session_path }
    ]
  end
end
