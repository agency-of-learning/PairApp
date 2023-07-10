class StandupMeetingPolicy < ApplicationPolicy
  def index?
    group_member? || user.admin?
  end

  def update?
    matching_user?
  end

  private

  def matching_user?
    record.user_id == user.id
  end

  def group_member?
    record.users.where(id: user.id).present?
  end
end
