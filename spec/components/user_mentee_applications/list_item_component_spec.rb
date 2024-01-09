# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplications::ListItemComponent, type: :component do
  let(:mentee_application) { create(:user_mentee_application, user_mentee_application_cohort:) }

  let(:cohort_name) { 'Test Cohort' }
  let(:user_mentee_application_cohort) { build(:user_mentee_application_cohort, name: cohort_name) }

  it "renders with the content 'Application for <cohort_name>'" do
    render_inline(described_class.new(mentee_application:))

    expect(page).to have_content("Application for #{cohort_name}")
  end
end
