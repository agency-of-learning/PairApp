# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::ModeratorComponent, type: :component do
  let(:moderator) { create(:user, :moderator) }

  before do
    render_inline(described_class.new(current_user: moderator))
  end

  it 'renders a link to the applications portal' do
    expect(page).to have_link('Applications Portal', href: admin_user_mentee_application_cohorts_path)
  end
end
