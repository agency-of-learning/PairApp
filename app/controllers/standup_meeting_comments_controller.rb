class StandupMeetingCommentsController < ApplicationController
  before_action :set_standup_meeting
  def index; end

  def show
    @standup_meeting_comment = StandupMeetingComment.find(params[:id])
    case @standup_meeting_comment.name
    when 'yesterday'
      @standup_meeting_comment.name = 'Yesterday'
    when 'today'
      @standup_meeting_comment.name = 'Today'
    when 'blockers'
      @standup_meeting_comment.name = 'Blockers'
    end
  end

  def new
    @section = params[:section]

    standup_meeting_id = params[:standup_meeting_id]

    @standup_meeting_comment = StandupMeetingComment.new(section: @section, standup_meeting_id:)
  end

  def edit; end

  def create
    @standup_meeting_comment = @standup_meeting.standup_meeting_comments.new(standup_meeting_comment_params)
    if @standup_meeting_comment.save
      redirect_to @standup_meeting_comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

  def set_standup_meeting
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
  end

  def standup_meeting_comment_params
    params.require(:standup_meeting_comment).permit(:content, :name, :standup_meeting_id)
  end
end
