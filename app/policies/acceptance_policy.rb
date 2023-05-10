class AcceptancePolicy < ApplicationPolicy
  attr_reader :user, :pair_request

  def initialize(user, pair_request)
    @user = user
    @pair_request = pair_request
  end

  def create?
    pair_request.pending? && user == pair_request.invitee
  end

end