# == Schema Information
#
# Table name: user_mentee_applications
#
#  id                       :bigint           not null, primary key
#  additional_information   :text
#  available_hours_per_week :integer          not null
#  city                     :string           not null
#  country                  :string           not null
#  github_url               :string
#  learned_to_code          :text             not null
#  linkedin_url             :string
#  project_experience       :text             not null
#  reason_for_applying      :text             not null
#  referral_source          :string
#  state                    :string           not null
#  status                   :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_user_mentee_applications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserMenteeApplication < ApplicationRecord
  belongs_to :user
  has_many :mentee_application_states, dependent: :destroy

  validates :available_hours_per_week, numericality: { greater_than: 0, less_than_or_equal_to: 60 }

  validates :city, :state, :country, :reason_for_applying, :learned_to_code, :project_experience,
    :available_hours_per_week, presence: true

  after_create :create_initial_application_state

  def current_status
    current_state.status
  end

  def current_state
    mentee_application_states.last
  end

  def next_status
    current_status_index = MenteeApplicationState::STATUSES.keys.index(current_status.to_sym)
    next_status_index = current_status_index.to_i + 1

    MenteeApplicationState::STATUSES.keys.fetch(next_status_index)
  end

  def promote_application(current_user)
    next_status = self.next_status
    mentee_application_states.build(status: next_status, status_changed_by_id: current_user.id).save
  end

  def reject_application(current_user)
    mentee_application_states.build(status: :rejected, status_changed_by_id: current_user.id).save
  end

  def can_promote?
    current_index = MenteeApplicationState.statuses[current_status.to_s]
    max_index = MenteeApplicationState.statuses.length - 2
    current_index < max_index && current_status != :rejected
  end
  

  def rejected?
    current_status == :rejected
  end

  def accepted?
    current_status == :accepted
  end

  def current_status
    mentee_application_states.last&.status&.to_sym
  end

  private

  def create_initial_application_state
    mentee_application_states.create(status: :pending)
  end
end
