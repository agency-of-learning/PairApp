# frozen_string_literal: true

class Navigation::AdminComponent < NavigationComponent
  private

  def home_path
    dashboards_path
  end

  def primary_links
    [
      { text: 'Standups', path: standup_meeting_groups_path },
      { text: 'Pair Requests', path: pair_requests_path },
      { text: 'Agency Blog', path: blog_posts_path },
      { text: 'Applications Portal', path: user_mentee_application_cohorts_path }
    ]
  end

  def dropdown_links
    [
      { text: 'My Profile', path: profile_path(user) },
      { text: 'Feedback', path: feedbacks_path },
      { text: 'My Blog', path: blog_path(user.blog_slug), class: 'border-b border-neutral pb-1' },
      { text: 'Invite New User', path: new_user_invitation_path, class: 'border-b border-neutral pb-1 mt-1' },
      { text: 'Account Settings', path: edit_user_registration_path, class: 'mt-1' },
      { text: 'Logout', path: destroy_user_session_path }
    ]
  end
end
