class AddPairRequestFeedbackFieldsToPairRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :pair_requests, :author_overall_rating, :integer
    add_column :pair_requests, :acceptor_overall_rating, :integer
    add_column :pair_requests, :author_partner_rating, :integer
    add_column :pair_requests, :acceptor_partner_rating, :integer
    add_column :pair_requests, :author_feedback_for_partner, :text
    add_column :pair_requests, :acceptor_feedback_for_partner, :text
  end
end
