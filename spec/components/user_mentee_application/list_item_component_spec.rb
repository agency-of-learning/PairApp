# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplication::ListItemComponent, type: :component do
  let(:mentee_application) { create(:user_mentee_application, user_mentee_application_cohort:) }

  context 'when there is no cohort for the application' do
    let(:user_mentee_application_cohort) { nil }

    it "renders with the content 'Application for The Agency of Learning'" do
      render_inline(described_class.new(mentee_application:))

      expect(page).to have_content('Application for The Agency of Learning')
    end
  end

  context 'when there is a cohort for the application' do
    let(:cohort_name) { 'Test Cohort' }
    let(:user_mentee_application_cohort) { build(:user_mentee_application_cohort, name: cohort_name) }

    it "renders with the content 'Application for <cohort_name>'" do
      render_inline(described_class.new(mentee_application:))

      expect(page).to have_content("Application for #{cohort_name}")
    end
  end
end
