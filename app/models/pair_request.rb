# == Schema Information
#
# Table name: pair_requests
#
#  id          :bigint           not null, primary key
#  duration    :float
#  when        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  acceptor_id :integer
#  author_id   :integer
#
class PairRequest < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :acceptor, class_name: "User", optional: true
end
