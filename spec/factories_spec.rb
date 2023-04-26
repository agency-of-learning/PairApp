require 'rails_helper'

RSpec.describe 'FactoryBot' do
  FactoryBot.factories.each do |factory|
    it "#{factory.name} should pass lint" do
      FactoryBot::Linter.new([factory]).lint!
    end
  end
end
