class PairRequest::CompletionPolicy < ApplicationPolicy
  alias_method :pair_request, :record

  def create?
    user == pair_request.author && pair_request.accepted? && pair_request.started?
  end
end

