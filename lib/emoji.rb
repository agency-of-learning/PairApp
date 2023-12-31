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

  attr_reader :caption

  def initialize(caption = DICTIONARY.keys.sample)
    @caption = caption
  end

  def emoji
    DICTIONARY[@caption]
  end

  class << self
    def captions
      DICTIONARY.keys
    end

    def emojis
      DICTIONARY.values
    end
  end
end
