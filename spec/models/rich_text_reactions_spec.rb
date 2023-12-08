require "rails_helper"

RSpec.describe RichTextReaction do
  describe "#emoji_caption" do
    it "returns the text description of an emoji" do
      thumbs_up = described_class.emojis.keys.first
      thumbs_up_caption = described_class.emojis.values.first
      rtr = described_class.new(emoji: thumbs_up)

      expect(rtr.emoji_caption).to eq(thumbs_up_caption)
    end

    it "returns nil if the emoji is not in the permissible set" do
      disguised_face = "🥸"
      rtr = described_class.new(emoji: disguised_face)

      expect(rtr.emoji_caption).to be_nil
    end
  end
end
