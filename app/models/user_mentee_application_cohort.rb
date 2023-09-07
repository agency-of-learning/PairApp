# == Schema Information
#
# Table name: user_mentee_application_cohorts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE), not null
#  active_date_range :daterange        not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class UserMenteeApplicationCohort < ApplicationRecord
  has_many :user_mentee_applications, dependent: nil

  validates :active_date_range, :name, presence: true

  after_save :deactivate_other_cohorts!, if: :active?

  scope :inactive, -> { where(active: false) }

  delegate :begin, :end, to: :active_date_range

  def self.active
    find_by(active: true)
  end

  private

  # rubocop: disable Rails/SkipsModelValidations
  def deactivate_other_cohorts!
    UserMenteeApplicationCohort.excluding(self).update_all(active: false)
  end
  # rubocop: enable Rails/SkipsModelValidations
end
