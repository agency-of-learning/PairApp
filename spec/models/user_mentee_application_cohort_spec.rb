# == Schema Information
#
# Table name: user_mentee_application_cohorts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE), not null
#  active_date_range :daterange        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe UserMenteeApplicationCohort do
  subject { build(:user_mentee_application_cohort) }

  context 'when saved' do
    let!(:other_active_cohort) { create(:user_mentee_application_cohort, active: true) }

    it 'deactivates other active cohort if cohort to be saved is active' do
      subject.active = true
      subject.run_callbacks :save
      expect(other_active_cohort.reload).not_to be_active
    end

    it 'does not deactivate other active cohort if cohort to be saved is inactive' do
      subject.active = false
      subject.run_callbacks :save
      expect(other_active_cohort.reload).to be_active
    end
  end
end
