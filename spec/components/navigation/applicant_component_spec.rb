# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::ApplicantComponent, type: :component do
  let(:moderator) { create(:user, :moderator) }

  before do
    render_inline(described_class.new(current_user: moderator))
  end

  it 'renders a link to the applications portal' do
    expect(page).to have_link('My Applications', href: user_mentee_applications_path)
  end

  it 'renders a link to invite new users' do
    expect(page).to have_link('Account Settings', href: edit_user_registration_path)
  end
end
