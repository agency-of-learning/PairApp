class PairRequest::CompletionNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_for_complete

  param :pair_request
end
