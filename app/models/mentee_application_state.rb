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

  private


  def self.next_status(mentee_application)
    current_state = current_state(mentee_application)

    rails "Can't promote #{self}" unless can_promote?(mentee_application)

    current_status_index = statuses.keys.index(current_state.status)
    next_status_index = current_status_index.to_i + 1

    statuses.keys.fetch(next_status_index)
  end

  def self.current_state(mentee_application)
    mentee_application.mentee_application_states.last
  end

  def self.current_status(mentee_application)
    mentee_application.mentee_application_states.last&.status&.to_sym
  end

  def self.can_promote?(mentee_application)
    current_state = current_state(mentee_application)
    !current_state.accepted? && !current_state.rejected?
  end
end
