class AdminPolicy
  attr_reader :user

  def initialize(user, _record=nil)
    @user = user
  end

  def admin?
    user.admin?
  end
end