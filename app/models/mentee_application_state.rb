# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  slug                       :string
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
#  index_on_slug_and_user_mentee_application_id                   (slug,user_mentee_application_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (status_changed_id => users.id)
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
class MenteeApplicationState < ApplicationRecord
  extend FriendlyId
  belongs_to :user_mentee_application, touch: true
  # rubocop:disable Rails/InverseOf
  belongs_to :reviewer, class_name: 'User', foreign_key: :status_changed_id, optional: true
  # rubocop:enable Rails/InverseOf

  friendly_id :status, use: :scoped, scope: :user_mentee_application

  validates :slug, uniqueness: { scope: :user_mentee_application_id }

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
