# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  time_zone  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :pair_requests_as_author, class_name: "PairRequest", foreign_key: "author_id"
  has_many :pair_requests_as_acceptor, class_name: "PairRequest", foreign_key: "acceptor_id"
end
