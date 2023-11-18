class CommentsController < ApplicationController
  def create
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
    commentable_type = params[:comment][:commentable_type]

    case commentable_type
    when 'YesterdayWork'
      commentable = @standup_meeting.yesterday_work_comments
    when 'TodayWork'
      commentable = @standup_meeting.today_work_comments
    when 'Blockers'
      commentable = @standup_meeting.blockers_comments
    else
      # Handle unknown commentable type
      redirect_to @standup_meeting, alert: 'Invalid comment type'
      return
    end

    @comment = commentable.new(comment_params)

    if @comment.save
      redirect_to @standup_meeting, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
