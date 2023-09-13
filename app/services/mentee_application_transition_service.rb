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
      valid_transitions: [:promote],
      promote_transition: :phone_screen_completed
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

  def call(application:, reviewer:, action:, note: nil)
    status = application.current_status.to_sym
    # enforce that the action is cast to a symbol before performing guard clause
    action = action.to_sym
    raise InvalidTransitionError unless STATUS_TRANSITION_MAPPING[status][:valid_transitions].include? action
    transition_status = action == :reject ? :rejected : STATUS_TRANSITION_MAPPING[status][:promote_transition]
    application.mentee_application_states.create!(status: transition_status, reviewer:, note:)
    # handle side effects
    case transition_status
    when :coding_challenge_sent then code_challenge_side_effects(application)
    when :accepted then accepted_side_effects(application)
    when :rejected then rejected_side_effects(application)
    end
    true
  end

  def valid_transitions(status:)
    MenteeApplicationTransitionService::STATUS_TRANSITION_MAPPING[status.to_sym][:valid_transitions]
  end

  private

  def code_challenge_side_effects(application)
    MenteeApplication::CodeChallengeNotification.deliver(application.user)
  end

  def accepted_side_effects(application)
    MenteeApplication::AcceptanceNotification.with(application:).deliver(application.user)
    application.user.update!(role: User.roles[:member])
  end

  def rejected_side_effects(application)
    MenteeApplication::RejectionNotification.deliver(application.user)
  end
end