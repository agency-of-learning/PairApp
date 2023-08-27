class ProfileForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_accessor :profile, :user

  attribute :current_resume_id, :integer
  attribute :bio, :string
  attribute :picture, :string
  attribute :job_title, :string
  attribute :location, :string
  attribute :job_search_status, :string
  attribute :slug, :string
  attribute :work_model_preferences, array: true, default: []
  attribute :resume
  attribute :resume_name, :string

  # this line is necessary in order to use the form_for helper
  delegate :persisted?, :model_name, :to_param, to: :profile
  delegate :resumes, to: :user

  # Resume and resume name must both be present to add a resume
  validates :resume_name, presence: { if: :resume }
  validates :job_search_status, :slug, presence: true
  validates :bio, length: { maximum: 500 }
  validates :job_title, length: { maximum: 100 }

  def initialize(profile:, user:, params: {})
    @profile = profile
    @user = user
    attributes = profile.attributes.slice(*self.class.attribute_names)
    super attributes.merge(params)
  end
end
