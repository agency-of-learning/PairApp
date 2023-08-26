# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplication::ActionButtonBuilderComponent, type: :component do
  let!(:mentee_application) { create(:user_mentee_application, :with_application_state) }
  let(:component) { described_class.new(mentee_application:) }

  context 'when current mentee application has a pending state' do
    it 'renders a Promote and Reject button' do
      component = described_class.new(mentee_application:)
      render_inline(component)

      expect(page).to have_button('Promote to next stage')
      expect(page).to have_button('Reject')
    end
  end

  context 'when current mentee application has a pending stage_three status' do
    it 'renders a Promote and Reject button' do
      mentee_application.mentee_application_states.last.stage_three!

      component = described_class.new(mentee_application:)
      render_inline(component)

      expect(page).to have_button('Promote to next stage')
      expect(page).to have_button('Reject')
    end
  end

  context 'when current mentee application has an accepted status' do
    it "renders 'Reject' button" do
      mentee_application.mentee_application_states.last.accepted!

      component = described_class.new(mentee_application:)
      render_inline(component)

      expect(page).to have_button('Reject')
    end
  end

  context 'when current mentee application has a rejected status' do
    it "returns a 'Restore' button" do
      mentee_application.mentee_application_states.last.rejected!

      component = described_class.new(mentee_application:)
      render_inline(component)

      expect(page).to have_button('Restore Application')
    end
  end
end
