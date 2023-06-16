# frozen_string_literal: true

class PairRequest::StatusButtonsComponent < ViewComponent::Base
  STATUS_POLICIES = {
    accept: PairRequest::AcceptancePolicy,
    reject: PairRequest::RejectionPolicy,
    complete: PairRequest::CompletionPolicy
  }.freeze

  def initialize(pair_request:, current_user:)
    @pair_request = pair_request
    @user = current_user
  end

  private

  attr_reader :user, :pair_request

  def policy(action)
    STATUS_POLICIES.fetch(action).new(user, pair_request)
  end
end
