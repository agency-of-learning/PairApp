module Emojis
  DICTIONARY = {
    'thumbs_up' => '👍',
    'thinking' => '🤔',
    'hooray' => '🎉',
    'shrug' => '🤷',
    'thumbs_down' => '👎',
    'eyes' => '👀'
  }.freeze

  def caption_to_emoji(caption)
    DICTIONARY[caption]
  end

  def emoji_captions
    DICTIONARY.keys
  end

  def emojis
    DICTIONARY.values
  end
end
