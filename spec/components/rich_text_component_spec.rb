# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RichTextComponent, type: :component do
  let!(:rich_text) { build(:action_text_rich_text) }
  let!(:user) { rich_text.record }

  it "renders the rich text content along with the user's full name" do
    render_inline described_class.new(rich_text:, user:)

    expect(page).to have_content(rich_text.to_plain_text)
      .and have_content(user.full_name)
  end

  it "renders nothing with no rich text content" do
    rich_text.body = ActionText::Content.new('')

    render_inline described_class.new(rich_text:, user:)

    expect(page).not_to have_content('body')
  end
end
