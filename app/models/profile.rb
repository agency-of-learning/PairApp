# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  job_search_status      :integer          default("actively_looking")
#  job_title              :string
#  location               :string
#  work_model_preferences :enum             is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  belongs_to :user

  enum job_search_status: {
    actively_looking: 0,
    open_to_opportunities: 1,
    not_looking: 2
  }

  WORK_MODELS = %w[inoffice hybrid remote].freeze
  validate :work_model_preferences_must_exist, :must_not_duplicate_preferences

  def work_model_preferences
    super || []
  end

  private

  def work_model_preferences_must_exist
    if work_model_preferences.any? { |preference| WORK_MODELS.exclude?(preference) }
      error_message = "must only include valid preferences: #{WORK_MODELS.to_sentence}"
      errors.add(:work_model_preferences, error_message)
    end
  end

  def must_not_duplicate_preferences
    if work_model_preferences.size != work_model_preferences.uniq.size
      errors.add(:work_model_preferences, 'must not contain duplicate preferences')
    end
  end
end
