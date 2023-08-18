require 'rails_helper'
RSpec.describe LandingHelper do
  describe '#cta_button' do
    it 'generates the correct button HTML' do
      html = cta_button('Test Button', 'test-icon-class')
      expect(html).to have_button('Test Button')
      expect(html).to have_selector('i.fa-solid.fa-arrow-right.fa-lg.test-icon-class')
    end
  end
end
