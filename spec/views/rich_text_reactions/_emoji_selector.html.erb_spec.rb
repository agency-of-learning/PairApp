# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rich_text_reactions/_emoji_selector.html.erb', type: :view do
  it 'renders a form to create a new rich text reaction' do
    rich_text_id = create(:rich_text_reaction).rich_text_id
    emojis = Emoji.captions.map { |caption| Emoji.new(caption) }

    render(
      partial: 'rich_text_reactions/emoji_selector',
      locals: { rich_text_id:, emojis: }
    )

    expect(rendered).to have_selector(
      "form[action='#{rich_text_reactions_path}']",
      visible: :hidden
    ).and have_selector(
      "input[value='#{rich_text_id}']",
      visible: :hidden
    )
  end
end
