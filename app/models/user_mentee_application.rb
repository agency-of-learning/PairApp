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

  delegate :rejected?, to: :current_state

  delegate :accepted?, to: :current_state

  def current_status
    current_state.status
  end

  def current_state
    mentee_application_states.last
  end

  def next_status
    return if accepted? || rejected?
    current_status_index = MenteeApplicationState.statuses.keys.index(current_status.to_sym)
    next_status_index = current_status_index.to_i + 1

    MenteeApplicationState.statuses.keys.fetch(next_status_index)
  end

  def promote_application(user)
    mentee_application_states.build(status: next_status, status_changed_by_id: user.id).save
  end

  def reject_application(user)
    mentee_application_states.build(status: :rejected, status_changed_by_id: user.id).save
  end

  def can_promote?
    !accepted? && !rejected?
  end

  def current_status
    mentee_application_states.last&.status&.to_sym
  end

  private

  def create_initial_application_state
    mentee_application_states.create(status: :pending)
  end
end
