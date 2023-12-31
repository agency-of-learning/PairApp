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

  describe '.for_rich_text' do
    context 'when given an ActionText::RichText record' do
      it 'returns all associated RichTextReaction records' do
        # Create a couple of reactions for the same rich text.
        reaction = create(:rich_text_reaction)
        create(:rich_text_reaction,
          user: create(:user),
          rich_text_id: reaction.rich_text_id)  

        reactions = described_class.for_rich_text(reaction.rich_text)

        expect(described_class.all - reactions).to be_empty
      end
    end
  end

  describe '.for_rich_texts' do
    context 'when given multiple ActionText::RichText ids' do
      it 'returns all associated RichTextReaction records' do
        # Create a couple of reactions for each rich text.
        100.times do
          reaction = create(:rich_text_reaction)
          create(:rich_text_reaction,
            user: create(:user),
            rich_text_id: reaction.rich_text_id)  
        end

        # The ids of the rich texts to find reactions for.
        rich_text_ids = described_class.distinct.pluck(:rich_text_id)

        reactions = described_class.for_rich_texts(rich_text_ids)

        expect(described_class.all - reactions).to be_empty
      end
    end
  end
end
