# == Schema Information
#
# Table name: rich_text_reactions
#
#  id           :bigint           not null, primary key
#  emoji        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  rich_text_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_rich_text_reactions_on_rich_text_id  (rich_text_id)
#  index_rich_text_reactions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (rich_text_id => action_text_rich_texts.id)
#  fk_rails_...  (user_id => users.id)
#
require "emoji"

class RichTextReaction < ApplicationRecord
  include Emoji

  belongs_to :user
  belongs_to :rich_text, class_name: "ActionText::RichText"

  # Return the text description of an emoji. Return nil if the emoji is not in
  # the set of emojis defined in the Emoji module.
  # e.g. "thumbs-up" for "👍"
  def emoji_caption
    caption(emoji)
  end

  class << self
    # Return the Emoji module's limited hash of emoji-to-caption pairs.
    def emojis
      Emoji::EMOJIS
    end
  end
end
