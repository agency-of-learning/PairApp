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
class RichTextReaction < ApplicationRecord
  # Permissible set of emojis for standup updates and comments.
  EMOJIS = {
    👍: "thumbs-up",
    🤔: "thinking",
    🎉: "hooray",
    🤷: "shrug",
    👎: "thumbs-down",
    👀: "eyes"
  }.freeze

  belongs_to :user
  belongs_to :rich_text, class_name: "ActionText::RichText"

  validates :emoji,
    inclusion: {
      in: EMOJIS.keys,
      message: 'must be present in permissible set'
    }

  # Return the text description of an emoji.
  # e.g. "thumbs-up" for "👍"
  def emoji_caption
    EMOJIS[emoji.to_sym]
  end

  class << self
    def emojis
      EMOJIS
    end
  end
end
