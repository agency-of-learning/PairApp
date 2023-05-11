class PairRequest::RejectionPolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def create?
    user_is_owner? && (pair_request.pending? || pair_request.accepted?)
  end

  private

  def user_is_owner?
    pair_request.author == user || pair_request.invitee == user
  end
end
