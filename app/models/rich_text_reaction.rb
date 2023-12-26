# == Schema Information
#
# Table name: rich_text_reactions
#
#  id            :bigint           not null, primary key
#  emoji_caption :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rich_text_id  :bigint           not null
#  user_id       :bigint           not null
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
require 'emoji'

class RichTextReaction < ApplicationRecord
  belongs_to :user
  belongs_to :rich_text, class_name: 'ActionText::RichText'

  validates :emoji_caption,
    inclusion: {
      in: Emoji.emoji_captions,
      message: 'must be present in permissible set'
    }

  # Return the emoji icon for the caption.
  # e.g. '👍' for 'thumbs_up'
  def emoji
    Emoji.caption_to_emoji(emoji_caption)
  end

  # Return all reactions, along with the IDs of users who made the reaction,
  # for the given +ActionText::RichText+, +rich_text+.
  def self.reactions(rich_text)
    result = RichTextReaction.where(rich_text:).pluck(:emoji_caption, :user_id)
    # e.g. [["thumbs_up", 3], ["thinking", 1]]

    result = result.group_by(&:shift)
    # e.g. { "thumbs_up" => [[1], [4], [2]], "thinking" => [[3]] }

    result.transform_values(&:flatten)
    # e.g. { "thumbs_up" => [1, 4, 2], "thinking" => [3] }
  end
end
