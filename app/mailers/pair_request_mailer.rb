class PairRequestMailer < ApplicationMailer
  def notify_for_create
    recipient = params[:recipient]

    mail(
      to: recipient.email,
      subject: 'Smoke Test'
    )
  end
end
