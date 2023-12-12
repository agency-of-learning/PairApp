# frozen_string_literal: true

class RichTextReaction::EmojiSelectorComponent < ViewComponent::Base
  class InvalidRichTextError < StandardError; end

  def initialize(rich_text_id:)
    @rich_text_reaction = RichTextReaction.new(rich_text_id:)
  end

  private

  attr_reader :rich_text_reaction

  # Render only if the +ActionText::RichText+ record exists.
  def render?
    ActionText::RichText.exists? @rich_text_reaction.rich_text_id
  end
end
