require 'rails_helper'
require 'emoji'

RSpec.describe Emoji do
  let(:caption) { described_class.captions.sample }

  describe '#emoji' do
    subject { described_class.new(caption) }

    it 'returns the emoji in string format' do
      expect(subject.emoji).to eq(Emoji::DICTIONARY[caption])
    end
  end

  describe '.captions' do
    it 'returns the set of allowed emoji captions' do
      expect(described_class.captions).to eq(described_class::DICTIONARY.keys)
    end
  end

  describe '.emojis' do
    it 'returns the set of allowed emojis' do
      expect(described_class.emojis).to eq(described_class::DICTIONARY.values)
    end
  end
end
