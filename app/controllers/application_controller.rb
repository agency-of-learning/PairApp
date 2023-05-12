class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ApplicationHelper

  # PaperTrail helper for getting current_user
  before_action :set_paper_trail_whodunnit

  # around_action :set_time_zone, if: :current_user

  private

  def set_time_zone(&)
    Time.use_zone(current_user.time_zone, &)
  end
end
