class PairRequestPolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def index?
    user_is_owner? || user.admin?
  end

  def show?
    user_is_owner? || user.admin?
  end

  def create?
    true
  end

  def accept?
    pair_request.pending? && user == pair_request.invitee
  end

  def reject?
    user_is_owner? && (pair_request.pending? || pair_request.accepted?)
  end

  private

  def user_is_owner?
    pair_request.author == user || pair_request.invitee == user
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        user.all_pair_requests
      end
    end

    private

    attr_reader :user, :scope
  end
end
