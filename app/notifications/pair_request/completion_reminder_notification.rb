class PairRequest::CompletionReminderNotification < Noticed::Base
  deliver_by :database,
    if: :pair_request_accepted?

  deliver_by :email,
    mailer: 'PairRequestMailer',
    method: :notify_author_of_concluded_pairing_session,
    delay: :now_to_end_of_meeting,
    if: :pair_request_accepted?

  param :pair_request

  private

  def now_to_end_of_meeting
    end_time = params[:pair_request].end_time
    ActiveSupport::Duration.build(end_time - Time.current)
  end

  def pair_request_accepted?
    params[:pair_request].accepted?
  end
end
