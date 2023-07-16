class PairRequest::CreationNotification < Noticed::Base
  deliver_by :email, mailer: 'PairRequestMailer', method: :creation
end
