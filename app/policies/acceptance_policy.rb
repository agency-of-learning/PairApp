class AcceptancePolicy < ApplicationPolicy
  def create?
    record.pending? && user == record.invitee
  end
end
