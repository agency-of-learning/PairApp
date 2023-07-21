class PairRequest::CreationNotification < Noticed::Base
  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_for_create

  param :pair_request
end
