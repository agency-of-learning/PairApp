class PairRequestMailer < ApplicationMailer
  before_action :set_pair_request

  def notify_for_create
    mail(subject: 'Pair Request Invite')
  end

  def notify_for_complete
    mail(subject: 'Pair Request Completed')
  end

  private

  def set_pair_request
    @pair_request = params[:pair_request]
  end
end
