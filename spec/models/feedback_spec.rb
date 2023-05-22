# == Schema Information
#
# Table name: feedbacks
#
#  id                 :bigint           not null, primary key
#  data               :jsonb
#  locked_at          :datetime
#  overall_rating     :integer          default(0), not null
#  referenceable_type :string           not null
#  status             :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  author_id          :bigint           not null
#  receiver_id        :bigint           not null
#  referenceable_id   :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_author_id      (author_id)
#  index_feedbacks_on_receiver_id    (receiver_id)
#  index_feedbacks_on_referenceable  (referenceable_type,referenceable_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (receiver_id => users.id)
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
