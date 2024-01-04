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
end
