class AcceptancePolicy < ApplicationPolicy
  def create?
    user_is_owner? && (record.pending? || record.accepted?)
  end

  private

  def user_is_owner?
    record.author == user || record.invitee == user
  end
end
