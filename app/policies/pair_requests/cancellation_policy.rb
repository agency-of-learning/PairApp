module PairRequests
  class CancellationPolicy < ApplicationPolicy
    alias_method :pair_request, :record

    def create?
      user == pair_request.author && (
        pair_request.pending? || pair_request.accepted?
      )
    end
  end
end
