# == Schema Information
#
# Table name: rich_text_reactions
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  rich_text_id :bigint           not null
#
# Indexes
#
#  index_rich_text_reactions_on_rich_text_id  (rich_text_id)
#
# Foreign Keys
#
#  fk_rails_...  (rich_text_id => action_text_rich_texts.id)
#
FactoryBot.define do
  factory :rich_text_reaction do
    rich_text { nil }
  end
end
