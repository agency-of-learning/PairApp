class RejectionPolicy < ApplicationPolicy
  attr_reader :user, :pair_request

  def initialize(user, pair_request)
    @user = user
    @pair_request = pair_request
  end

  def create?
    user_is_owner? && (pair_request.pending? || pair_request.accepted?)
  end

  private

  def user_is_owner?
    pair_request.author == user || pair_request.invitee == user
  end

end