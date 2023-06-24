require 'rails_helper'

RSpec.describe 'FactoryBot' do
  FactoryBot.factories.each do |factory|
    it "#{factory.name} should pass lint" do
      expect(FactoryBot::Linter.new([factory]).lint!).not_to raise(Error)
    end
  end
end
