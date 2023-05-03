# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # NOTE: we will want to add confirmable later on. Will require sendgrid setup (or w/e client we use.)
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

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

  scope :invitee_select_for, ->(user) { User.excluding(user).pluck(:email, :id) }

  def all_pair_requests
    authored_pair_requests.or(received_pair_requests)
  end
end
