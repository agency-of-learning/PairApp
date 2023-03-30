# == Schema Information
#
# Table name: pair_requests
#
#  id                            :bigint           not null, primary key
#  acceptor_feedback_for_partner :text
#  acceptor_overall_rating       :integer
#  acceptor_partner_rating       :integer
#  author_feedback_for_partner   :text
#  author_overall_rating         :integer
#  author_partner_rating         :integer
#  duration                      :float
#  when                          :datetime
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  acceptor_id                   :integer
#  author_id                     :integer
#
require "test_helper"

class PairRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
