module Emoji
  # Limited set of emojis we want for our updates and comments.
  EMOJIS = {
    "👍": "thumbs-up",
    "🤔": "thinking",
    "🎉": "hooray",
    "🤷": "shrug",
    "👎": "thumbs-down",
    "👀": "eyes"
  }.freeze

  def caption(emoji)
    EMOJIS[emoji.to_sym]
  end
end
