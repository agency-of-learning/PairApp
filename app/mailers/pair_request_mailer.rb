class PairRequestMailer < ApplicationMailer
  before_action :set_pair_request

  def notify_invitee_of_new_pair_request
    mail(subject: 'Pair Request Invite')
  end

  def notify_author_of_accepted_request
    mail(subject: 'Pair Request Accepted')
  end

  def notify_invitee_of_completed_pairing_session
    mail(subject: 'Pair Request Completed')
  end

  def notify_author_of_concluded_pairing_session
    mail(subject: 'Mark Pair Request as Completed')
  end

  private

  def set_pair_request
    @pair_request = params[:pair_request]
  end
end
