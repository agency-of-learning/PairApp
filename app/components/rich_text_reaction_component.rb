# frozen_string_literal: true

class RichTextReactionComponent < ViewComponent::Base
  class InvalidRichTextError < StandardError; end

  attr_reader :rich_text_reaction

  def initialize(rich_text_id:)
    @rich_text_reaction = RichTextReaction.new(rich_text_id:)
  end

  # Render only if the +ActionText::RichText+ record exists.
  def render?
    ActionText::RichText.exists? @rich_text_reaction.rich_text_id
  end
end
