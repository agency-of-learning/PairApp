# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::AdminComponent, type: :component do
  let(:admin) { create(:user, :admin) }

  before do
    render_inline(described_class.new(current_user: admin))
  end

  it 'renders a link to the applications portal' do
    expect(page).to have_link('Applications Portal', href: user_mentee_application_cohorts_path)
  end

  it 'renders a link to invite new users' do
    expect(page).to have_link('Invite New User', href: new_user_invitation_path)
  end
end
