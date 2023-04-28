# == Schema Information
#
# Table name: pair_requests
#
#  id         :bigint           not null, primary key
#  duration   :float            not null
#  status     :integer          default("pending"), not null
#  when       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  invitee_id :bigint           not null
#
# Indexes
#
#  index_pair_requests_on_author_id   (author_id)
#  index_pair_requests_on_invitee_id  (invitee_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (invitee_id => users.id)
#

require 'rails_helper'

RSpec.describe PairRequest do
  it "is valid with a duration longer than 15 minutes" do
    request = build(:pair_request, duration: 20.minutes)
    expect(request).to be_valid
  end

  it "is invalid with a duration lower than 15 minutes" do
    request = build(:pair_request, duration: 10.minutes)
    expect(request).not_to be_valid
  end

  it "is invalid with a 'when' more than a month into the future" do
    request = build(:pair_request, when: Date.today + 2.months)
    expect(request).not_to be_valid
  end

  it "is valid with a 'when' less than a month into the future" do
    request = build(:pair_request, when: Date.today + 2.weeks)
    expect(request).to be_valid
  end
end
