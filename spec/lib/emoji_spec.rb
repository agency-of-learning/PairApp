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
end
