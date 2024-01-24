module EmojisHelper
  def all_emojis
    Emoji.captions.map { |caption| Emoji.new(caption) }
  end
end
