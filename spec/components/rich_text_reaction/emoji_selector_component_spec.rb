# frozen_string_literal: true

require "rails_helper"

RSpec.describe RichTextReaction::EmojiSelectorComponent, type: :component do
  it "renders the emoji selector for creating a reaction for the given rich text id" do
    rich_text_id = create(:standup_meeting).yesterday_work_description.id

    render_inline described_class.new(rich_text_id:)

    expect(rendered_content).to have_field(
      "rich_text_reaction[rich_text_id]",
      type: :hidden,
      with: rich_text_id
    )
    expect(rendered_content).to have_selector(
      "form[action=\"#{rich_text_reactions_path}\"][method=\"post\"]",
      visible: :false
    )
    RichTextReaction.emojis.keys.each do |emoji|
      expect(rendered_content).to have_button(
        "rich_text_reaction[emoji]",
        value: emoji.to_s,
        visible: false
      )
    end
  end

  it "does not render if the given rich text id is invalid" do
    render_inline described_class.new(rich_text_id: 1)

    expect(rendered_content).to have_no_selector("details#emoji-selector")
  end
end
