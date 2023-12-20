# frozen_string_literal: true

class UserMenteeApplication::NotesComponent < ViewComponent::Base
  def initialize(mentee_application:)
    @mentee_application = mentee_application
  end

  private

  attr_reader :mentee_application

  def status_and_notes
    status_and_notes = {}
    mentee_application.mentee_application_states.each do |state|
      status = state.status.to_s.humanize
      note = state.note || 'n/a'
      status_and_notes[status] = note
    end
    status_and_notes
  end

  def current_status
    @mentee_application.current_status.to_s.humanize
  end
end
