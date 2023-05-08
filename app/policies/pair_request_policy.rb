class PairRequestPolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def index?
    (pair_request.author == user || pair_request.invitee == user) || super
  end

  def show?
    (pair_request.author == user || pair_request.invitee == user) || super
  end

  def create?
    true
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
