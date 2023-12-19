require 'rails_helper'

RSpec.describe RichTextReaction do
  it 'is valid with an emoji in the permissible set' do
    emoji_caption = described_class.emoji_captions.first
    rich_text_reaction = described_class.new(emoji_caption:)

    expect(rich_text_reaction.errors[:emoji_caption]).to be_empty
  end

  it 'is invalid with an emoji not in the permissible set' do
    rich_text_reaction = described_class.new(emoji_caption: 'disguised_face')
    rich_text_reaction.valid?

    expect(rich_text_reaction.errors[:emoji_caption]).to be_present
  end

  describe '#emoji' do
    it 'returns the emoji for a caption' do
      emoji_caption = described_class.emoji_captions.first
      rich_text_reaction = described_class.new(emoji_caption:)

      expect(rich_text_reaction.emoji)
        .to eq(RichTextReaction::EMOJI_DICT[emoji_caption])
    end
  end
end
