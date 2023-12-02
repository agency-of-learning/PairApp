class StandupMeetingCommentPolicy < ApplicationPolicy
  def destroy?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
