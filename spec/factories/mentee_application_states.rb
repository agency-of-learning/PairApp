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
FactoryBot.define do
  factory :mentee_application_state do
    user_mentee_application { nil }
    status { 1 }
    note { 'MyText' }
    status_changed_by_id { 1 }
  end
end
