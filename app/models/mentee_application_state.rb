# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer          default("pending"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  status_changed_by_id       :integer
#  user_mentee_application_id :bigint           not null
#
# Indexes
#
#  index_mentee_application_states_on_user_mentee_application_id  (user_mentee_application_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
class MenteeApplicationState < ApplicationRecord
  belongs_to :user_mentee_application

  STATUSES = {
    pending: 0,
    stage_one: 1,
    stage_two: 2,
    stage_three: 3,
    stage_four: 4,
    accepted: 5,
    rejected: 6
  }.freeze

  enum status: STATUSES
end
