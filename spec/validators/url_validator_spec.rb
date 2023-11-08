require 'rails_helper'

class TestModel
  include ActiveModel::Model

  attr_accessor :test_url

  validates :test_url, url: true
end

RSpec.describe UrlValidator do
  subject { TestModel.new(test_url:) }

  context 'when the url is invalid' do
    let(:test_url) { '🎉.com' }

    it 'is invalid' do
      expect(subject).not_to be_valid
    end

    it 'has an invalid url error message' do
      subject.valid?
      expect(subject.errors[:test_url]).to eq(['must be valid URL'])
    end
  end

  context 'when the url does not contain https' do
    let(:test_url) { 'test.com' }

    it 'is invalid' do
      expect(subject).not_to be_valid
    end

    it 'must include https' do
      subject.valid?
      expect(subject.errors[:test_url]).to eq(['must include https'])
    end
  end

  context 'when the url is valid and has https' do
    let(:test_url) { 'https://test.com' }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
