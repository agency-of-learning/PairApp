class FeedbackPolicy < ApplicationPolicy
  alias_method :feedback, :record

  def show?
    user == feedback.author || (user == feedback.receiver && feedback.completed?)
  end

  def update?
    return true if user.admin?

    user == feedback.author && !feedback.locked?
  end

  def destroy?
    user.admin?
  end

  private

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.my_feedback
    end
  end

  def user_is_owner?
    user == feedback.author || user == feedback.receiver
  end
end
