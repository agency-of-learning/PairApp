# frozen_string_literal: true

class Emoji
  DICTIONARY = {
    'THUMBS_UP' => '👍',
    'THUMBS_DOWN' => '👎',
    'THINKING' => '🤔',
    'HOORAY' => '🎉',
    'SHRUG' => '🤷',
    'EYES' => '👀'
  }.freeze

  class << self
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
end
