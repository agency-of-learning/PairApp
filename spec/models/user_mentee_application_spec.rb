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
#  user_mentee_application_cohort_id :bigint           not null
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

  describe '#active?' do
    subject { build_stubbed(:user_mentee_application, user_mentee_application_cohort: cohort) }

    context 'when the mentee application belongs to an active cohort' do
      let(:cohort) { build_stubbed(:user_mentee_application_cohort, active: true) }

      it 'is active' do
        expect(subject).to be_active
      end
    end

    context "when the mentee applicatios doesn't belong to a cohort" do
      let(:cohort) { nil }

      it 'is not active' do
        expect(subject).not_to be_active
      end
    end

    context 'when the mentee application belongs to an inactive cohort' do
      let(:cohort) { build_stubbed(:user_mentee_application_cohort, active: false) }

      it 'is not active' do
        expect(subject).not_to be_active
      end
    end
  end

  describe '#in_review?' do
    before do
      create(:mentee_application_state, status:, user_mentee_application: mentee_application)
    end

    context 'when the status is accepted' do
      let(:status) { :accepted }

      it 'is not in review' do
        expect(mentee_application).not_to be_in_review
      end
    end

    context 'when the status is rejected' do
      let(:status) { :rejected }

      it 'is not in review' do
        expect(mentee_application).not_to be_in_review
      end
    end

    context 'when the status is not rejected or accepted' do
      let(:status) { :stage_one }

      it 'is in review' do
        expect(mentee_application).to be_in_review
      end
    end
  end
end
