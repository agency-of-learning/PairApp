# == Schema Information
#
# Table name: user_mentee_application_cohorts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE), not null
#  active_date_range :daterange        not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe UserMenteeApplicationCohort do
  subject { build(:user_mentee_application_cohort) }

  describe '#save' do
    let!(:other_active_cohort) { create(:user_mentee_application_cohort, active: true) }

    context 'when the cohort to be saved is active' do
      before do
        subject.active = true
        subject.run_callbacks :save
      end

      it 'deactivates other active cohort' do
        expect(other_active_cohort.reload).not_to be_active
      end

      it 'keeps the currently saving cohort active' do
        expect(subject).to be_active
      end
    end

    context 'when the cohort to be saved is inactive' do
      before do
        subject.active = false
        subject.run_callbacks :save
      end

      it 'does not deactivate other active cohort if cohort to be saved is inactive' do
        expect(other_active_cohort.reload).to be_active
      end
    end
  end

  describe '.active' do
    before do
      create_list(:user_mentee_application_cohort, 2, active: false)
    end

    context 'when there is an active cohort' do
      let!(:active_cohort) { create(:user_mentee_application_cohort, active: true) }

      it 'returns the active cohort' do
        expect(described_class.active).to eq active_cohort
      end
    end

    context 'when there is not an active cohort' do
      it 'returns nil' do
        expect(described_class.active).to be_nil
      end
    end
  end

  describe '#application_for_user?' do
    subject { create(:user_mentee_application_cohort) }

    let(:user) { create(:user) }

    context 'when the given user does not have an application with the cohort' do
      before do
        create(:user_mentee_application, user_mentee_application_cohort: subject)
      end

      it 'returns false' do
        expect(subject.application_for_user?(user)).to be false
      end
    end

    context 'when the given user does have an application with the cohort' do
      before do
        create(:user_mentee_application, user_mentee_application_cohort: subject, user:)
      end

      it 'returns true' do
        expect(subject.application_for_user?(user)).to be true
      end
    end
  end
end
