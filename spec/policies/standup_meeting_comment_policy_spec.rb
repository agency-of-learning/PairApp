require 'rails_helper'

RSpec.describe StandupMeetingCommentPolicy, type: :policy do
  subject { described_class }

  let(:member) { build(:user) }
  # let(:not_author_member) { build(:user) }

  let(:not_owned_comment) { build(:standup_meeting_comment) }
  let(:authored_comment) { build(:standup_meeting_comment, user: member) }

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    it 'denies access if user is not author of comment' do
      expect(subject).not_to permit(member, not_owned_comment)
    end

    it 'grants access if user is author of comment' do
      expect(subject).to permit(member, authored_comment)
    end
  end
end
