class StandupMeetingGroupsController < ApplicationController
  before_action :set_standup_meeting_group, only: %i[edit update destroy]

  def index
    @standup_meeting_groups = policy_scope(StandupMeetingGroup)
  end

  def show
    @standup_meeting_group = StandupMeetingGroup.includes(:standup_meetings).find(params[:id])
    authorize @standup_meeting_group
  end

  def new
    @standup_meeting_group = StandupMeetingGroup.new
  end

  def edit; end

  def create
    @standup_meeting_group = StandupMeetingGroup.new(standup_meeting_group_params)

    authorize(@standup_meeting_group)

    respond_to do |format|
      if @standup_meeting_group.save
        format.html do
          redirect_to standup_meeting_group_url(@standup_meeting_group),
            notice: 'Standup meeting group was successfully created.'
        end

      else
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
          redirect_to standup_meeting_group_url(@standup_meeting_group),
            notice: 'Standup meeting group was successfully created.'
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
