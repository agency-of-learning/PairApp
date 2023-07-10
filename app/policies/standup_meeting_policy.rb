class StandupMeetingPolicy < ApplicationPolicy
  def index?
    group_member? || user.admin?
  end

  def create?
    group_member?
  end

  def update?
    matching_user?
  end

  private

  def matching_user?
    record.user_id == user.id
  end

  def group_member?
    record.users.exists?(user.id)
  end
end
