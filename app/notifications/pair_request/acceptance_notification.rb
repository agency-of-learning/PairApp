class PairRequest::AcceptanceNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_for_accept

  param :pair_request
end
