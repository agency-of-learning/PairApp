class PairRequestMailer < ApplicationMailer
  def notify_for_create
    @recipient = params[:recipient]
    @pair_request = params[:pair_request]

    mail(
      to: @recipient.email,
      subject: 'Pair Request Invite'
    )
  end
end
