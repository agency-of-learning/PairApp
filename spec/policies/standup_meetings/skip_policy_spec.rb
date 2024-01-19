# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetings::SkipPolicy, type: :policy do
  subject { described_class }

  permissions :create? do
    let(:standup_meeting) { build(:standup_meeting) }

    it 'grants access if the user is the standup meeting owner' do
      expect(subject).to permit(standup_meeting.user, standup_meeting)
    end

    it 'denies access if the user is not the standup meeting owner' do
      wrong_user = build(:user)
      expect(subject).to permit(wrong_user, standup_meeting)
    end
  end
end
