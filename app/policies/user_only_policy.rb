class UserOnlyPolicy
  attr_reader :user

  def initialize(user, _record = nil)
    @user = user
  end

  delegate :admin?, to: :user
end
