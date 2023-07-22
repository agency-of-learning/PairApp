# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  bio        :text
#  job_title  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile do
  pending "add some examples to (or delete) #{__FILE__}"
end
