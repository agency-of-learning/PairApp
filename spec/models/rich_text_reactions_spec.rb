require "rails_helper"

RSpec.describe RichTextReaction do
  it "is valid with an emoji in the permissible set" do
    thumbs_up = described_class.emojis.keys.first
    rich_text_reaction = described_class.new(emoji: thumbs_up)

    expect(rich_text_reaction.errors[:emoji]).to be_empty
  end

  it "is invalid with an emoji not in the permissible set" do
    rich_text_reaction = described_class.new(emoji: "🥸")
    rich_text_reaction.valid?

    expect(rich_text_reaction.errors[:emoji]).to be_present
  end

  describe "#emoji_caption" do
    it "returns the text description of an emoji" do
      thumbs_up = described_class.emojis.keys.first
      thumbs_up_caption = described_class.emojis.values.first
      rich_text_reaction = described_class.new(emoji: thumbs_up)

      expect(rich_text_reaction.emoji_caption).to eq(thumbs_up_caption)
    end
  end
end
