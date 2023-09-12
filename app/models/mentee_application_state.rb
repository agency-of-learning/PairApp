# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer          default("application_received"), not null
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
    application_received: 0,
    coding_challenge_sent: 1,
    coding_challenge_received: 2,
    coding_challenge_approved: 3,
    phone_screen_scheduled: 4,
    phone_screen_completed: 5,
    accepted: 6,
    rejected: 7
  }

  class << self
    # state machine for mentee application
    def next(status:)
      return if %i[accepted rejected].include?(status)
      statuses.keys[statuses.keys.index(status.to_s) + 1]
    end
  end
end
