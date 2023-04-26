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

require 'rails_helper'

RSpec.describe PairRequest do
  
end
