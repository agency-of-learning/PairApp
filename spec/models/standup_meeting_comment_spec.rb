# == Schema Information
#
# Table name: standup_meeting_comments
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standup_meeting_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_standup_meeting_comments_on_standup_meeting_id  (standup_meeting_id)
#  index_standup_meeting_comments_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (standup_meeting_id => standup_meetings.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StandupMeetingComment do
  pending "add some examples to (or delete) #{__FILE__}"
end
