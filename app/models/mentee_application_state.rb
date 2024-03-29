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
  belongs_to :user_mentee_application, touch: true
  # rubocop:disable Rails/InverseOf
  belongs_to :reviewer, class_name: 'User', foreign_key: :status_changed_id, optional: true
  # rubocop:enable Rails/InverseOf

  enum status: {
    application_received: 0,
    coding_challenge_sent: 1,
    coding_challenge_received: 2,
    coding_challenge_approved: 3,
    phone_screen_scheduled: 4,
    phone_screen_completed: 5,
    accepted: 6,
    rejected: 7,
    withdrawn: 8
  }

  def valid_transitions
    MenteeApplicationTransitionService.valid_transitions(status:)
  end
end
