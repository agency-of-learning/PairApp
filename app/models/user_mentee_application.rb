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
    # NOTE: the logic here isn't entirely correct:
    # it should be setting the `current_state` (update)
    # and then creating the next state. (create)
    # Maybe this all could be more simplified by only creating the next state later on.
    next_status = MenteeApplicationState.next(status:)
    mentee_application_states.build(status: next_status, status_changed_id: user.id).save!
  end

  def reject_application!(user)
    # This one has a similar issue as above.
    # The only difference is it should also be setting the `current_state` (update)
    mentee_application_states.build(status: :rejected, status_changed_id: user.id).save!
  end

  private

  def create_initial_application_state
    mentee_application_states.create(status: :pending)
  end
end
