# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("member"), not null
#  time_zone              :string           default("UTC"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # NOTE: we will want to add confirmable later on. Will require sendgrid setup (or w/e client we use.)
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :authored_pair_requests,
    class_name: 'PairRequest',
    foreign_key: 'author_id',
    dependent: :destroy,
    inverse_of: 'author'
  has_many :received_pair_requests,
    class_name: 'PairRequest',
    foreign_key: 'invitee_id',
    dependent: :destroy,
    inverse_of: 'invitee'

  has_many :authored_feedbacks,
    class_name: 'Feedback',
    foreign_key: 'author_id',
    dependent: :destroy,
    inverse_of: 'author'

  has_many :received_feedbacks,
    class_name: 'Feedback',
    foreign_key: 'receiver_id',
    dependent: :destroy,
    inverse_of: 'receiver'

  has_many :references, as: :referenceable, dependent: :destroy, class_name: 'Feedback'

  has_many :standup_meeting_groups_users, dependent: :destroy, class_name: 'StandupMeetingGroupUser'
  has_many :standup_meetings, dependent: :destroy
  has_many :standup_meeting_groups, through: :standup_meeting_groups_users

  has_many :blog_posts, dependent: :destroy

  has_one :profile, dependent: :destroy
  has_one :mentee_application, class_name: 'UserMenteeApplication', dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_profile!

  def self.invite!(attributes = {}, invited_by = nil, options = {}, &)
    default_name = { first_name: 'First', last_name: 'Last' }
    super(attributes.merge(default_name), invited_by, options, &)
  end

  def my_pair_requests
    authored_pair_requests.or(received_pair_requests)
  end

  def my_feedback
    authored_feedbacks.or(received_feedbacks)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def time_zone_identifier
    ActiveSupport::TimeZone.new(time_zone).tzinfo.identifier
  end

  enum role: {
    member: 0,
    admin: 1
  }
end
