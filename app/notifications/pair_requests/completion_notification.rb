class PairRequests::CompletionNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_invitee_of_completed_pairing_session

  param :pair_request
end
