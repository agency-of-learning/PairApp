# == Schema Information
#
# Table name: standup_meetings
#
#  id                         :bigint           not null, primary key
#  blockers_description       :text             not null
#  meeting_date               :date             not null
#  status                     :integer          default("attended"), not null
#  today_work_description     :text             not null
#  yesterday_work_description :text             not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  standup_meeting_group_id   :bigint           not null
#  user_id                    :bigint           not null
#
# Indexes
#
#  index_standup_meetings_on_standup_meeting_group_id  (standup_meeting_group_id)
#  index_standup_meetings_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (standup_meeting_group_id => standup_meeting_groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StandupMeeting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
