# Preview all emails at http://localhost:3000/rails/mailers/mentee_application_mailer
class PairRequestMailerPreview < ActionMailer::Preview
  def notify_invitee_of_new_pair_request
    pair_request = PairRequest.last
    PairRequestMailer.with(recipient: pair_request.invitee, pair_request:).notify_invitee_of_new_pair_request
  end

  def notify_author_of_accepted_request
    pair_request = PairRequest.last
    PairRequestMailer.with(recipient: pair_request.author, pair_request:).notify_author_of_accepted_request
  end

  def notify_invitee_of_completed_pairing_session
    pair_request = PairRequest.last
    PairRequestMailer.with(recipient: pair_request.invitee, pair_request:).notify_invitee_of_completed_pairing_session
  end

  def notify_author_of_concluded_pairing_session
    pair_request = PairRequest.last
    PairRequestMailer.with(recipient: pair_request.author, pair_request:).notify_author_of_concluded_pairing_session
  end
end
