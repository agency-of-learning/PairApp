module MenteeApplicationTransitionService
  class InvalidTransitionError < StandardError; end
  extend self

  STATUS_TRANSITION_MAPPING = {
    application_received: {
      valid_transitions: %i[promote reject],
      promote_transition: :coding_challenge_sent
    },
    coding_challenge_sent: {
      valid_transitions: [:promote],
      promote_transition: :coding_challenge_received
    },
    coding_challenge_received: {
      valid_transitions: %i[promote reject],
      promote_transition: :coding_challenge_approved
    },
    coding_challenge_approved: {
      valid_transitions: [:promote],
      promote_transition: :phone_screen_scheduled
    },
    phone_screen_scheduled: {
      valid_transitions: [:promote]
    },
    phone_screen_completed: {
      valid_transitions: %i[promote reject],
      promote_transition: :accepted
    },
    accepted: {
      valid_transitions: []
    },
    rejected: {
      valid_transitions: []
    }
  }.freeze

  def promote!(application:, user:, note: nil)
    status = application.current_status.to_sym
    raise InvalidTransitionError unless STATUS_TRANSITION_MAPPING[status][:valid_transitions].include? :promote
    promote_transition = STATUS_TRANSITION_MAPPING[status][:promote_transition]
    application.mentee_application_states.create!(status: promote_transition, status_changed: user, note:)
    invoke_side_effects(application, promote_transition, user)
    true
  end

  private

  def invoke_side_effects(application, promote_transition, user)
    case promote_transition
    when :accepted then accepted_side_effects(application, user)
    end
  end

  def accepted_side_effects(application, _user)
    MenteeApplication::AcceptanceNotification.deliver(application.user)
  end
end
