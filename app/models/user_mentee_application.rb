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
#  user_mentee_application_cohort_id :bigint           not null
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
  belongs_to :user_mentee_application_cohort

  has_many :mentee_application_states, dependent: :destroy
  # rubocop:disable Rails/InverseOf
  has_one :current_state, -> {
                            order(status: :desc).limit(1)
                          }, class_name: 'MenteeApplicationState', dependent: nil
  # rubocop:enable Rails/InverseOf

  validates :available_hours_per_week, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 60 }

  validates :city, :state, :country, :reason_for_applying, :learned_to_code, :project_experience,
    :available_hours_per_week, presence: true

  validates :github_url,
    format: { with: %r{/github.com/}, message: 'must be a github url' },
    allow_blank: true,
    url: true

  validates :linkedin_url,
    format: { with: %r{linkedin.com/in}, message: 'must be a linkedin url' },
    allow_blank: true,
    url: true

  after_create :create_initial_application_state
  after_create_commit :send_application_submission_notifications

  delegate :accepted?, :rejected?, :status, to: :current_state
  delegate :created_at, to: :current_state, prefix: 'last_action'

  delegate :active?, to: :user_mentee_application_cohort
  delegate :current_resume, to: :user

  scope :order_newest_first, -> { order(created_at: :desc) }
  scope :order_by_latest_updated, -> { order(updated_at: :desc) }

  alias_method :cohort, :user_mentee_application_cohort

  def current_status
    status
  end

  def in_review?
    %w[application_received accepted rejected withdrawn].none?(current_status)
  end

  def application_received?
    current_status == 'application_received'
  end

  def action_available?
    current_state.valid_transitions.present?
  end

  private

  def create_initial_application_state
    mentee_application_states.create(status: :application_received)
  end

  def send_application_submission_notifications
    UserMenteeApplications::ApplicantSubmissionNotification
      .with(application: self).deliver(user)
    UserMenteeApplications::AdminSubmissionNotification
      .with(application: self).deliver(User.super_admins)
  end
end
