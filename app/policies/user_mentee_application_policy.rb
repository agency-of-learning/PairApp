class UserMenteeApplicationPolicy < ApplicationPolicy
  def index?
    user.applicant?
  end

  def show?
    user.application_reviewer? || matching_user?
  end

  def new?
    matching_user?
  end

  def create?
    true
  end

  def update?
    matching_user?
  end

  private

  def matching_user?
    record.user_id == user.id
  end
end
