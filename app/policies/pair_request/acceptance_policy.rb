class PairRequest::AcceptancePolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def create?
    user == pair_request.invitee && pair_request.pending?
  end
end

