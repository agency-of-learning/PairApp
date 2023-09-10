# == Schema Information
#
# Table name: user_mentee_applications
#
#  id                                :bigint           not null, primary key
#  additional_information            :text
#  available_hours_per_week          :integer          not null
#  city                              :string           not null
#  country                           :string           not null
#  github_url                        :string
#  learned_to_code                   :text             not null
#  linkedin_url                      :string
#  project_experience                :text             not null
#  reason_for_applying               :text             not null
#  referral_source                   :string
#  state                             :string           not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  user_id                           :bigint           not null
#  user_mentee_application_cohort_id :bigint
#
# Indexes
#
#  idx_user_mentee_applications_on_mentee_application_cohort_id  (user_mentee_application_cohort_id)
#  index_user_mentee_applications_on_user_id                     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (user_mentee_application_cohort_id => user_mentee_application_cohorts.id)
#
class UserMenteeApplication < ApplicationRecord
  belongs_to :user
  belongs_to :user_mentee_application_cohort, optional: true

  has_many :mentee_application_states, dependent: :destroy
  # rubocop:disable Rails/InverseOf
  has_one :current_state, -> {
                            order(status: :desc).limit(1)
                          }, class_name: 'MenteeApplicationState', dependent: nil
  # rubocop:enable Rails/InverseOf

  validates :available_hours_per_week, numericality: { greater_than: 0, less_than_or_equal_to: 60 }

  validates :city, :state, :country, :reason_for_applying, :learned_to_code, :project_experience,
    :available_hours_per_week, presence: true

  after_create :create_initial_application_state

  delegate :accepted?, :rejected?, :status, to: :current_state

  def current_status
    status
  end

  def promote_application!(user)
    next_status = MenteeApplicationState.next(status:)
    mentee_application_states.create!(status: next_status, status_changed_id: user.id)
    reload
  end

  def reject_application!(user)
    mentee_application_states.create!(status: :rejected, status_changed_id: user.id)
    reload
  end

  private

  def create_initial_application_state
    mentee_application_states.create(status: :pending)
  end
end
