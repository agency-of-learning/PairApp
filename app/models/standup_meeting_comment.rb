# == Schema Information
#
# Table name: standup_meeting_comments
#
#  id                       :bigint           not null, primary key
#  name                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  action_text_rich_text_id :bigint           not null
#
# Indexes
#
#  index_standup_meeting_comments_on_action_text_rich_text_id  (action_text_rich_text_id)
#
# Foreign Keys
#
#  fk_rails_...  (action_text_rich_text_id => action_text_rich_texts.id)
#
class StandupMeetingComment < ApplicationRecord
  belongs_to :rich_text, class_name: 'ActionText::RichText', foreign_key: :action_text_rich_text_id
end
