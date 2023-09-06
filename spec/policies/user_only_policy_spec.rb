require 'rails_helper'

RSpec.describe UserOnlyPolicy, type: :policy do
  subject { described_class }

  let(:admin_user) { create(:user, role: "admin" ) }
  let(:member_user) { create(:user, role: "member" ) }
  let(:applicant_user) { create(:user, role: "applicant" ) }

  permissions :admin? do
    it "denies access if user is not admin" do
      expect(subject).not_to permit(member_user)
      expect(subject).not_to permit(applicant_user)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end
  end
end