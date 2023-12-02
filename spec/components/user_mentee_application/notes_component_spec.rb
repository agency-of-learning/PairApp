# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplication::NotesComponent, type: :component do
  let(:cohort_name) { 'Test Cohort' }
  let(:user_mentee_application_cohort) { build(:user_mentee_application_cohort, name: cohort_name) }
  let(:mentee_application) { create(:user_mentee_application, user_mentee_application_cohort:) }

  it 'renders with the latest status selected' do
    mentee_application.current_state.update(status: 4)
    render_inline(described_class.new(mentee_application:))

    expect(page).to have_select('status', selected: 'Phone screen scheduled')
  end
end
