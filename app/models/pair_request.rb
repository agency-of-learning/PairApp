# == Schema Information
#
# Table name: pair_requests
#
#  id                            :bigint           not null, primary key
#  acceptor_feedback_for_partner :text
#  acceptor_overall_rating       :integer
#  acceptor_partner_rating       :integer
#  author_feedback_for_partner   :text
#  author_overall_rating         :integer
#  author_partner_rating         :integer
#  duration                      :float
#  when                          :datetime
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  acceptor_id                   :integer
#  author_id                     :integer
#
class PairRequest < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :acceptor, class_name: "User", optional: true

  validates :when, presence: true

  def feedback_needed?(user)
    # binding.break
    if user == self.author && author_overall_rating.nil? || author_feedback_for_partner.nil? || author_partner_rating.nil?
      true
    elsif user == self.acceptor && acceptor_overall_rating.nil? || acceptor_feedback_for_partner.nil? || acceptor_partner_rating.nil?
      true
    else
      false
    end
  end

  def session_status
    session_ending_time = self.when + self.duration.hours
    session_in_progress = self.when < Time.now && session_ending_time > Time.now

    if session_in_progress
      return "Session is in progress"
    elsif self.when < session_ending_time
      return "Session hasn't started yet"
    elsif self.when > session_ending_time
      return "Session has ended"
    end
  end

end

