# == Schema Information
#
# Table name: user_mentee_applications
#
#  id                                :bigint           not null, primary key
#  additional_information            :text
#  available_hours_per_week          :integer          not null
#  city                              :string           not null
#  country                           :string           not null
#  github_url                        :string
#  learned_to_code                   :text             not null
#  linkedin_url                      :string
#  project_experience                :text             not null
#  reason_for_applying               :text             not null
#  referral_source                   :string
#  state                             :string           not null
#  status                            :integer
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  user_id                           :bigint           not null
#  user_mentee_application_cohort_id :bigint
#
# Indexes
#
#  idx_user_mentee_applications_on_mentee_application_cohort_id  (user_mentee_application_cohort_id)
#  index_user_mentee_applications_on_user_id                     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (user_mentee_application_cohort_id => user_mentee_application_cohorts.id)
#
require 'rails_helper'

RSpec.describe UserMenteeApplication do
  let(:user) { create(:user) }
  let(:mentee_application) { create(:user_mentee_application) }

  describe '#create' do
    it 'creates an initial application state' do
      expect(mentee_application.mentee_application_states.count).to eq(1)
    end

    it 'sets the initial application state to pending' do
      expect(mentee_application.current_status).to eq('pending')
    end
  end

  describe '#reject_application!' do
    before do
      mentee_application.reject_application!(user)
    end

    it 'creates a rejected application state' do
      expect(mentee_application.current_status).to eq('rejected')
    end

    it 'creates a new application state record with status_changed_by_id of current_user' do
      expect(mentee_application.current_state.status_changed_id).to eq(user.id)
    end
  end

  describe '#promote_application!' do
    it 'creates a new application state record with status_changed_by_id of current_user' do
      mentee_application.promote_application!(user)
      expect(mentee_application.current_state.status_changed_id).to eq(user.id)
    end
  end
end
