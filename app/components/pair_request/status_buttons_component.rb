# frozen_string_literal: true

class PairRequest::StatusButtonsComponent < ViewComponent::Base
  STATUS_POLICIES = {
    accept: PairRequest::AcceptancePolicy,
    reject: PairRequest::RejectionPolicy,
    complete: PairRequest::CompletionPolicy,
    cancel: PairRequest::CancellationPolicy
  }.freeze

  STYLES = {
    button: 'btn-sm',
    link: 'btn-link btn-xs sm:btn-sm hover:no-underline'
  }.freeze

  def initialize(pair_request:, current_user:, style: :button)
    @pair_request = pair_request
    @user = current_user
    @style = style
  end

  private

  attr_reader :user, :pair_request, :style

  def policy(action)
    STATUS_POLICIES.fetch(action).new(user, pair_request)
  end
end
