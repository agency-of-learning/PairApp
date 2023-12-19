require 'rails_helper'

class MockModel
  include Reactionable
end

RSpec.describe MockModel, type: :model do
  describe '#reactions' do
    let!(:standup_meeting) { create(:standup_meeting) }
    let!(:rich_text) { standup_meeting.yesterday_work_description }

    it 'returns all reaction info for an update' do
      # Emulate a user reacting to her own update, and another user reacting to
      # the first user's update.
      user = standup_meeting.user
      other_user = create(:user)
      my_reaction = RichTextReaction.emojis.keys.first.to_s
      other_reaction = RichTextReaction.emojis.keys.second.to_s
      RichTextReaction.create(emoji: my_reaction, user:, rich_text:)
      RichTextReaction.create(emoji: other_reaction, user: other_user, rich_text:)

      reactions = subject.reactions(rich_text)

      # Output should tell who made which reaction.
      expected_reactions = { my_reaction => [user.id], other_reaction => [other_user.id] }
      expect(reactions).to eq(expected_reactions)
    end

    it 'returns an empty hash if an update has no reactions' do
      reactions = subject.reactions(rich_text)
      expect(reactions).to be_empty
    end
  end
end
