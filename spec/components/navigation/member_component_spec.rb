# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::MemberComponent, type: :component do
  let(:member) { create(:user) }

  before do
    render_inline(described_class.new(current_user: member))
  end

  it 'renders a link to the applications portal' do
    expect(page).to have_link('Standups', href: standup_meeting_groups_path)
  end

  it 'renders a link to invite new users' do
    expect(page).to have_link('Account Settings', href: edit_user_registration_path)
  end
end
