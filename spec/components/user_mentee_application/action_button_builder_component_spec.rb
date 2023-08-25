# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMenteeApplication::ActionButtonBuilderComponent, type: :component do
  let(:mentee_application) { create(:user_mentee_application) }
  let!(:mentee_application_state) { create(:mentee_application_state, user_mentee_application: mentee_application) }  # Using the correct attribute name
  
  let(:component) { described_class.new(mentee_application: mentee_application) }
  

  context "when current mentee application has a pending state " do
    it "returns HTML that includes a button element" do
      component = described_class.new(mentee_application: mentee_application)
      rendered_component = render_inline(component)
      
      expect(rendered_component.text).to include("stage_two")
    end
  end
  
  context "when current mentee application has a pending stage_three status " do
    it "returns HTML that includes a button element" do
      mentee_application.mentee_application_states.last.stage_three!

      component = described_class.new(mentee_application: mentee_application)
      rendered_component = render_inline(component)
      
      expect(rendered_component.text).to include("stage_four")
    end
  end

  context "when current mentee application has a accepted status " do
    it "returns 'accepted' text" do
      mentee_application.mentee_application_states.last.accepted!

      component = described_class.new(mentee_application: mentee_application)
      rendered_component = render_inline(component)

      expect(rendered_component.text).to include("Accepted")
    end
  end
end

