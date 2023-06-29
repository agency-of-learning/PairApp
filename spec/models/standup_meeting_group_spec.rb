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
require 'rails_helper'

RSpec.describe StandupMeetingGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
