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

    it 'sets the initial application state to application_received' do
      expect(mentee_application.current_status).to eq('application_received')
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

    context 'when the status is withdrawn' do
      let(:status) { :withdrawn }

      it 'is not in review' do
        expect(mentee_application).not_to be_in_review
      end
    end

    context 'when the status is not rejected or accepted' do
      let(:status) { :application_received }

      it 'is in review' do
        expect(mentee_application).to be_in_review
      end
    end
  end

  describe 'Notification and Alert Enqueueing on Creation' do
    before do
      ActiveJob::Base.queue_adapter.enqueued_jobs = []
      create(:user, email: 'daniel@agencyoflearning.com')
      create(:user, email: 'dave@agencyoflearning.com')
    end

    it 'enqueues application submission notifications after create commit' do
      expect {
        create(:user_mentee_application)
      }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_submission)
        .and have_enqueued_mail(MenteeApplicationMailer,
          :notify_admin_of_submission).exactly(User.super_admins.count).times
    end
  end

  describe '#available_hours_per_week' do
    it 'is valid' do
      expect(mentee_application).to be_valid
    end

    context 'when available hours per week is not within valid range' do
      subject { build_stubbed(:user_mentee_application, available_hours_per_week:) }

      let(:available_hours_per_week) { -1 }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#github_url' do
    it 'is valid' do
      expect(mentee_application).to be_valid
    end

    context 'when a github_url is not entered' do
      subject { build_stubbed(:user_mentee_application, github_url:) }

      let(:github_url) { 'https://www.example.com' }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#linkedin_url' do
    it 'is valid' do
      expect(mentee_application).to be_valid
    end

    context 'when a github_url is not entered' do
      subject { build_stubbed(:user_mentee_application, linkedin_url:) }

      let(:linkedin_url) { 'https://www.example.com' }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
