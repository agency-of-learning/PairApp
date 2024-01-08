class StandupMeetingCommentsController < ApplicationController
  before_action :set_standup_meeting, only: %i[create]

  def edit; end

  def create
    @standup_meeting_comment = @standup_meeting.standup_meeting_comments.new(standup_meeting_comment_params)
    @standup_meeting_comment.user = current_user
    if @standup_meeting_comment.save
      redirect_to @standup_meeting_comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @standup_meeting_comment = StandupMeetingComment.find(params[:id])
    authorize @standup_meeting_comment
    respond_to do |format|
      if @standup_meeting_comment.destroy
        format.html do
          redirect_back(fallback_location: root_path, notice: 'Comment was successfully deleted.')
        end
      else
        format.html { render :show, status: :unprocessable_entity }
      end
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
