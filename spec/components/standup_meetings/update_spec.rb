# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetings::Update, type: :component do
  let(:owner) { build(:user) }

  context 'with an update to display' do
    it "renders the user's full name and the standup update" do
      update = Faker::Lorem.sentence

      render_inline described_class.new(update:, owner:)

      expect(page)
        .to have_selector("span[class='grow whitespace-pre-line']",
          text: update)
        .and have_selector("span[class='flex flex-col justify-center font-bold']",
          text: owner.full_name)
    end
  end

  context 'with no update to display' do
    it 'does not render thew view component' do
      update = ''

      render_inline described_class.new(update:, owner:)

      expect(page).to have_no_content(owner.full_name)
        .and have_no_selector("span[class='grow whitespace-pre-line']")
    end
  end
end
