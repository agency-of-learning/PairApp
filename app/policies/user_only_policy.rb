class UserOnlyPolicy < ApplicationPolicy
  attr_reader :user

  def agent?
    User::AGENT_ROLES.include?(user.role)
  end

  # the delegate method forwards the admin? method call @user's admin? method
  delegate :admin?, :applicant?, to: :user
end
