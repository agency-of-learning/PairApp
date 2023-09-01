# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer          default("pending"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  status_changed_id          :bigint
#  user_mentee_application_id :bigint           not null
#
# Indexes
#
#  index_mentee_application_states_on_status_changed_id           (status_changed_id)
#  index_mentee_application_states_on_user_mentee_application_id  (user_mentee_application_id)
#
# Foreign Keys
#
#  fk_rails_...  (status_changed_id => users.id)
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
class MenteeApplicationState < ApplicationRecord
  belongs_to :user_mentee_application

  enum status: {
    pending: 0,
    stage_one: 1,
    stage_two: 2,
    stage_three: 3,
    stage_four: 4,
    accepted: 5,
    rejected: 6
  }

  class << self
    # state machine for mentee application
    def next(status:)
      return if status == :accepted || status == :rejected
      statuses.keys[statuses.keys.index(status.to_s) + 1]
    end
  end
end
