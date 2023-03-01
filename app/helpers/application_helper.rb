module ApplicationHelper
  # NOTE: move to specific datetime place (forget name)
  def pretty_datetime(timestamp)
    timestamp.strftime('%B %d, %Y at %l:%M %p')
  end
end
