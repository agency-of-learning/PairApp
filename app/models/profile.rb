# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  location               :string
#  slug                   :string
#  work_model_preferences :enum             is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_profiles_on_slug     (slug) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_one_attached :picture do |attachable|
    attachable.variant :square, resize_to_fill: [256, 256]
  end

  validates :picture, content_type: ['image/png', 'image/jpeg']
  validates :slug, format: { with: /\A[\w\-]+\z/, message: 'must be alphanumeric with - or _ only' }

  enum job_search_status: {
    not_job_searching: 0,
    open_to_opportunities: 1,
    open_to_work: 2
  }

  WORK_MODELS = %w[onsite hybrid remote].freeze
  validate :work_model_preferences_must_exist, :must_not_duplicate_preferences

  def work_model_preferences
    super || []
  end

  def work_model_preferences=(values)
    super(values.reject(&:empty?))
  end

  def to_s
    user.full_name
  end

  def slug_candidates
    [
      :slug,
      [:slug, :id],
    ]
  end

  private

  def work_model_preferences_must_exist
    if work_model_preferences.any? { |preference| WORK_MODELS.exclude?(preference) }
      error_message = "must only include valid preferences: #{WORK_MODELS.to_sentence}"
      errors.add(:work_model_preferences, error_message)
    end
  end

  def must_not_duplicate_preferences
    return if work_model_preferences.size == work_model_preferences.uniq.size

    errors.add(:work_model_preferences, 'must not contain duplicate preferences')
  end
end
