class UserOnlyPolicy
  attr_reader :user

  def initialize(user, _record = nil)
    @user = user
  end

  # the delegate method forwards the admin? method call @user's admin? method
  delegate :admin?, :applicant?, to: :user
end
