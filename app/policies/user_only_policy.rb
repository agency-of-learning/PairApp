class UserOnlyPolicy < ApplicationPolicy
  attr_reader :user

  # the delegate method forwards the admin? method call @user's admin? method
  delegate :admin?, :applicant?, to: :user
end
