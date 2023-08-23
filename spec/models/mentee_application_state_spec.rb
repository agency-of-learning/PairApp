# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  status_changed_by_id       :integer
#  user_mentee_application_id :bigint           not null
#
# Indexes
#
#  index_mentee_application_states_on_user_mentee_application_id  (user_mentee_application_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
require 'rails_helper'

RSpec.describe MenteeApplicationState, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
