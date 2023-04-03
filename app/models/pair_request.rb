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



  def feed_back_needed?
    if author_overall_rating.nil? && author_feedback_for_partner.nil? && author_partner_rating.nil? && acceptor_overall_rating.nil? && acceptor_feedback_for_partner.nil? && acceptor_partner_rating.nil?
      p "Feedback needed by both parties"
      return "author and acceptor"
   
    elsif author_overall_rating.nil? && author_feedback_for_partner.nil? && author_partner_rating.nil?
      p "Feedback needed by auhtor"
      return "author"
    
    elsif acceptor_overall_rating.nil? && acceptor_feedback_for_partner.nil? && acceptor_partner_rating.nil?
      p "Feedback needed by acceptor"
      return "acceptor"
    end

  end

  def feedback_nedeed_by_user(user)
   
    if user == self.author
   
      if self.feed_back_needed? == "author" || self.feed_back_needed? == "author and acceptor"
        p 'true'
        return true
      end
    elsif user == self.acceptor
   
      if self.feed_back_needed? == "acceptor" || self.feed_back_needed? == "author and acceptor"
        p 'true'
        return true
      end
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

