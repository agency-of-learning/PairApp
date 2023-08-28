require 'rails_helper'
RSpec.describe LandingHelper do
  describe '#cta_button' do
    it 'generates the correct button HTML' do
      html = cta_button('Test Button', '#')

      expect(html).to have_link('Test Button', href: '#')
      expect(html).to have_selector('i.fa-solid.fa-arrow-right.fa-lg')
    end
  end
end
