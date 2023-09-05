# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplication::ActionButtonBuilderComponent, type: :component do
  context 'when the current user is an admin' do
    let(:mentee_application) { create(:user_mentee_application) }
    let(:current_user) { create(:user, :admin) }

    context 'when current mentee application has a pending state' do
      it 'renders a Promote and Reject button' do
        component = described_class.new(mentee_application:, current_user:)
        render_inline(component)

        expect(page).to have_button('Promote to next stage')
        expect(page).to have_button('Reject')
      end
    end

    context 'when current mentee application has a pending stage_three status' do
      it 'renders a Promote and Reject button' do
        mentee_application.mentee_application_states.last.stage_three!

        component = described_class.new(mentee_application:, current_user:)
        render_inline(component)

        expect(page).to have_button('Promote to next stage')
        expect(page).to have_button('Reject')
      end
    end

    context 'when current mentee application has an accepted status' do
      it 'renders no text' do
        mentee_application.mentee_application_states.last.accepted!

        component = described_class.new(mentee_application:, current_user:)
        render_inline(component)

        expect(page.all('button')).to be_empty
      end
    end

    context 'when current mentee application has a rejected status' do
      it 'returns no text' do
        mentee_application.mentee_application_states.last.rejected!

        component = described_class.new(mentee_application:, current_user:)
        render_inline(component)

        expect(page.all('button')).to be_empty
      end
    end
  end

  context 'when the current user is not an admin' do
    let(:current_user) { create(:user, :admin) }
    let(:mentee_application) { create(:user_mentee_application) }

    it 'renders nothing' do
      component = described_class.new(mentee_application:, current_user:)
      render_inline(component)
      expect(page.all('button')).to be_empty
    end
  end
end
