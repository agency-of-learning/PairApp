module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def pretty_datetime(timestamp)
    timestamp.strftime("%B %d, %Y at %l:%M %p")
  end
end
