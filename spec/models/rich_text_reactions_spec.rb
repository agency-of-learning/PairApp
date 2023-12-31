require 'rails_helper'

RSpec.describe RichTextReaction do
  it 'is valid with an emoji in the permissible set' do
    emoji_caption = Emoji.captions.sample
    rich_text_reaction = described_class.new(emoji_caption:)

    expect(rich_text_reaction.errors[:emoji_caption]).to be_empty
  end

  it 'is invalid with an emoji not in the permissible set' do
    rich_text_reaction = described_class.new(emoji_caption: 'disguised_face')
    rich_text_reaction.valid?

    expect(rich_text_reaction.errors[:emoji_caption]).to be_present
  end

  describe '.reactions' do
    let!(:standup_meeting) { create(:standup_meeting) }
    let!(:rich_text) { standup_meeting.yesterday_work_description }

    it 'returns all reaction info for an update' do
      # Emulate a user reacting to her own update, and another user reacting to
      # the first user's update.
      user = standup_meeting.user
      other_user = create(:user)
      my_reaction = Emoji.captions.first
      other_reaction = Emoji.captions.second
      described_class.create(emoji_caption: my_reaction, user:, rich_text:)
      described_class.create(
        emoji_caption: other_reaction,
        user: other_user,
        rich_text:
      )

      reactions = described_class.reactions(rich_text)

      # Output should tell who made which reaction.
      expected_reactions = { my_reaction => [user.id], other_reaction => [other_user.id] }
      expect(reactions).to eq(expected_reactions)
    end

    it 'returns an empty hash if an update has no reactions' do
      reactions = described_class.reactions(rich_text)
      expect(reactions).to be_empty
    end
  end
end
