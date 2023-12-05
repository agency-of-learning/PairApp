# == Schema Information
#
# Table name: standup_meetings
#
#  id                       :bigint           not null, primary key
#  meeting_date             :date             not null
#  status                   :integer          default("draft"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  standup_meeting_group_id :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_standup_meetings_on_standup_meeting_group_id  (standup_meeting_group_id)
#  index_standup_meetings_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (standup_meeting_group_id => standup_meeting_groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StandupMeeting do
  let(:standup_meeting) { create(:standup_meeting) }
  let(:yesterday_section) { 'yesterday_work_description' }
  let(:today_section) { 'today_work_description' }

  describe '#comments' do
    before do
      create_list(:standup_meeting_comment, 2, standup_meeting:, name: yesterday_section)
      create_list(:standup_meeting_comment, 3, standup_meeting:, name: 'today_section')
    end

    it 'returns the comments for the given section' do
      comments = standup_meeting.comments(yesterday_section)
      expect(comments.count).to eq(2)
      expect(comments.all? { |comment| comment.name == yesterday_section }).to be true
    end

    it 'does not return comments for other sections' do
      comments = standup_meeting.comments(yesterday_section)
      expect(comments.all? { |comment| comment.name == today_section }).to be false
    end
  end

  describe '#section_content' do
    it 'returns the rich text content for the given section' do
      content = standup_meeting.section_content(yesterday_section)
      expect(content).to eq(standup_meeting.yesterday_work_description)
    end

    it 'does not return content for other sections' do
      content = standup_meeting.section_content(yesterday_section)
      expect(content).not_to eq(standup_meeting.today_work_description)
    end
  end
end
