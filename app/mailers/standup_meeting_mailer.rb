class StandupMeetingMailer < ApplicationMailer
  before_action :set_standup_meeting

  def notify_member_of_daily_meeting
    mail(subject: "#{@standup_meeting_group.name} - Standup Meeting Reminder")
  end

  private

  def set_standup_meeting
    @standup_meeting = params[:standup_meeting]
    @standup_meeting_group = @standup_meeting.standup_meeting_group
  end
end
