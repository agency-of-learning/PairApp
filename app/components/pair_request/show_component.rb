# frozen_string_literal: true

class PairRequest::ShowComponent < ViewComponent::Base
  include PairRequestsHelper

  def initialize(pair_request:, current_user:)
    @pair_request = pair_request
    @user = current_user
  end

  attr_reader :pair_request, :user
end
