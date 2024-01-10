class PairRequests::AcceptanceNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_author_of_accepted_request

  param :pair_request
end
