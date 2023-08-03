class StandupMeetingGroupsController < ApplicationController
  before_action :set_standup_meeting_group, only: %i[edit update destroy]

  def index
    @my_standup_meeting_groups = policy_scope(StandupMeetingGroup).includes(:standup_meeting_groups_users,
      :standup_meetings)
    @joinable_standup_meeting_groups = StandupMeetingGroup.includes(:standup_meeting_groups_users)
                                                          .excluding(@my_standup_meeting_groups)
  end

  def show
    @standup_meeting_group = StandupMeetingGroup.includes(:standup_meetings,
      :standup_meeting_groups_users).find(params[:id])
    authorize @standup_meeting_group
    meeting_date = Date.current
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.find_by(user_id: current_user)
    @pagy, @standup_meetings = pagy(
      @standup_meeting_group.standup_meetings.where(user: current_user).order(meeting_date: :desc),
      items: 10
    )
    @current_user_standup_meeting = current_user.standup_meetings
                                                .find_by(
                                                  meeting_date:,
                                                  standup_meeting_group: @standup_meeting_group
                                                ) || @standup_meetings.new(
                                                  user: current_user,
                                                  meeting_date:
                                                )
  end

  def new
    @standup_meeting_group = StandupMeetingGroup.new
    authorize(@standup_meeting_group)
  rescue Pundit::NotAuthorizedError
    redirect_to standup_meeting_groups_url, notice: 'Must be an admin to create a new standup meeting group'
  end

  def edit; end

  def create
    @standup_meeting_group = StandupMeetingGroup.new(standup_meeting_group_params)

    authorize(@standup_meeting_group)

    respond_to do |format|
      if @standup_meeting_group.save
        format.turbo_stream do
          @new_standup_meeting_group = StandupMeetingGroup.new

          flash.now[:success] = "#{@standup_meeting_group.name} was successfully created."
        end

        format.html do
          redirect_to standup_meeting_group_url(@standup_meeting_group),
            notice: 'Standup meeting group was successfully created.'
        end
      else
        format.turbo_stream do
          flash.now[:form_errors] = @standup_meeting_group.errors.full_messages
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @standup_meeting_group

    respond_to do |format|
      if @standup_meeting_group.update(standup_meeting_group_params)
        format.html do
          redirect_to standup_meeting_group_url(@standup_meeting_group),
            notice: 'Standup meeting group was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @standup_meeting_group

    respond_to do |format|
      if @standup_meeting_group.destroy
        format.html do
          redirect_to standup_meeting_groups_url,
            notice: 'Standup meeting group was successfully deleeted.'
        end
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_standup_meeting_group
    @standup_meeting_group = StandupMeetingGroup.find(params[:id])
  end

  def standup_meeting_group_params
    params.require(:standup_meeting_group).permit(:name, :start_time, :frequency, :active)
  end
end
