module Reactionable
  # Return all reactions, along with the IDs of users who made the reaction,
  # for the given +ActionText::RichText+, +rich_text+.
  def reactions(rich_text)
    result = RichTextReaction.where(rich_text:).pluck(:emoji_caption, :user_id)
    # e.g. [["thumbs_up", 3], ["thinking", 1]]

    result = result.group_by(&:shift)
    # e.g. { "thumbs_up" => [[1], [4], [2]], "thinking" => [[3]] }

    result.transform_values(&:flatten)
    # e.g. { "thumbs_up" => [1, 4, 2], "thinking" => [3] }
  end
end
