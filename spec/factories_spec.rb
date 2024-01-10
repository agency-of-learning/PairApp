require 'rails_helper'

RSpec.describe 'FactoryBot' do
  FactoryBot.factories.each do |factory|
    next if factory.name == :action_text_rich_text

    # rubocop:disable RSpec/NoExpectationExample
    it "#{factory.name} should pass lint" do
      FactoryBot::Linter.new([factory]).lint!
    end
    # rubocop:enable RSpec/NoExpectationExample
  end
end
