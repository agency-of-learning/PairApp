require 'rails_helper'

RSpec.describe Null::User do
  subject { described_class.new }

  describe '#admin?' do
    it 'is not an admin' do
      expect(subject).not_to be_admin
    end
  end

  describe '#member?' do
    it 'is not an member' do
      expect(subject).not_to be_member
    end
  end

  describe '#present?' do
    it 'is not present' do
      expect(subject).not_to be_present
    end
  end

  describe '#blank?' do
    it 'is blank' do
      expect(subject).to be_blank
    end
  end
end
