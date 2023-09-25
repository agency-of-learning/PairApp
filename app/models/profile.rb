# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  github_link            :string
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  linked_in_link         :string
#  location               :string
#  personal_site_link     :string
#  slug                   :string
#  twitter_link           :string
#  visibility             :integer          default("private"), not null
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
  after_validation :move_friendly_id_error_to_slug

  has_one_attached :picture do |attachable|
    attachable.variant :square, resize_to_fill: [256, 256]
    attachable.variant :icon, resize_to_fill: [48, 48]
  end

  validates :picture, content_type: ['image/png', 'image/jpeg']
  validates :slug, format: { with: /\A[\w\-]+\z/, message: 'must be alphanumeric with - or _ only' }
  validates :slug, uniqueness: { case_sensitive: false, message: 'already taken' }

  validates :github_link,
    format: { with: /github.com/, message: 'must be a github link' },
    allow_blank: true
  validates :linked_in_link,
    format: { with: %r{linkedin.com/in}, message: 'must be a linkedin link' },
    allow_blank: true
  validates :twitter_link,
    format: { with: /twitter.com/, message: 'must be a twitter link' },
    allow_blank: true

  enum job_search_status: {
    not_job_searching: 0,
    open_to_opportunities: 1,
    open_to_work: 2
  }

  enum visibility: {
    private: 0,
    public: 1
  }, _suffix: true

  WORK_MODELS = %w[onsite hybrid remote].freeze
  validate :work_model_preferences_must_exist, :must_not_duplicate_preferences

  LINK_TYPES = %i[linked_in_link github_link personal_site_link twitter_link].freeze

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
      %i[slug id]
    ]
  end

  def toggle_visibility!
    private_visibility? ? public_visibility! : private_visibility!
  end

  private

  def move_friendly_id_error_to_slug
    errors.add :slug, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end

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
