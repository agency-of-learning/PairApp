# == Schema Information
#
# Table name: user_mentee_applications
#
#  id                       :bigint           not null, primary key
#  additional_information   :text
#  available_hours_per_week :integer          not null
#  city                     :string           not null
#  country                  :string           not null
#  github_url               :string
#  learned_to_code          :text             not null
#  linkedin_url             :string
#  project_experience       :text             not null
#  reason_for_applying      :text             not null
#  referral_source          :string
#  state                    :string           not null
#  status                   :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_user_mentee_applications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserMenteeApplication do
  let(:user) { create(:user) }
  let(:mentee_application) { create(:user_mentee_application) }

  it 'creates a new mentee_application_state with the next status and current_user_id' do
    initial_state_count = mentee_application.mentee_application_states.count

    allow(mentee_application).to receive(:next_status).and_return('stage_two')

    mentee_application.promote_application(user)

    expect(mentee_application.mentee_application_states.count).to eq(initial_state_count + 1)
    last_state = mentee_application.mentee_application_states.last
    
    expect(last_state.status).to eq('stage_two')
    expect(last_state.status_changed_by_id).to eq(user.id)
  end
end
