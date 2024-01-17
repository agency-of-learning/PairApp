# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplications::ReapplyCtaComponent, type: :component do
  context 'when the active cohort is nil' do
    it 'renders nothing' do
      render_inline(described_class.new(active_cohort: nil, last_application: nil))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the active cohort is present' do
    let(:user_mentee_application_cohort) { build_stubbed(:user_mentee_application_cohort) }

    context 'when the last application is absent' do
      it 'renders a link to apply' do
        render_inline(described_class.new(active_cohort: user_mentee_application_cohort, last_application: nil))

        expect(page).to have_link('Click To Apply!')
      end
    end

    context 'when the latest application is for the current cohort' do
      let(:last_application) { build_stubbed(:user_mentee_application, user_mentee_application_cohort:) }

      it 'renders nothing' do
        render_inline(described_class.new(active_cohort: user_mentee_application_cohort, last_application:))

        expect(page).not_to have_selector('body')
      end
    end

    context 'when the latest application is not for the current cohort' do
      let(:last_application) { build_stubbed(:user_mentee_application) }

      it 'renders a link to reapply' do
        render_inline(described_class.new(active_cohort: user_mentee_application_cohort, last_application:))

        expect(page).to have_link('Click To Reapply!')
      end
    end
  end
end
