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
FactoryBot.define do
  factory :rich_text_reaction do
    # +rich_text_owner+ can be given by the user of this factory, and it may
    # be any persisted ActiveRecord model record. By default, a User record is
    # used.
    transient do
      rich_text_owner { user }
    end

    user
    emoji_caption { Emoji.captions.sample }
    rich_text { association(:action_text_rich_text, rich_text_owner:) }
  end
end
