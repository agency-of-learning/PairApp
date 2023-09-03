# == Schema Information
#
# Table name: user_mentee_application_cohorts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE), not null
#  active_date_range :daterange        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class UserMenteeApplicationCohort < ApplicationRecord
  has_many :user_mentee_applications, dependent: nil

  validates :active_date_range, :active, presence: true
end
