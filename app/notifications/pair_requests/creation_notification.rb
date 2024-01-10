class PairRequests::CreationNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_invitee_of_new_pair_request

  param :pair_request
end
