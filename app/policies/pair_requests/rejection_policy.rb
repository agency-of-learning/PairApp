class PairRequests::RejectionPolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def create?
    pair_request.invitee == user && (pair_request.pending? || pair_request.accepted?)
  end
end
