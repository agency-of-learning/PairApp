# == Schema Information
#
# Table name: standup_meeting_groups
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  frequency  :integer          default("daily"), not null
#  name       :string           not null
#  start_time :time             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StandupMeetingGroup < ApplicationRecord
  enum frequency: {
    daily: 0
  }
end
