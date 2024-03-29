# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("applicant"), not null
#  time_zone              :string           default("UTC"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  describe '#my_pair_requests' do
    let!(:user) { create(:user) }
    let!(:authored_request) { create(:pair_request, author: user) }
    let!(:received_request) { create(:pair_request, invitee: user) }

    it "fetches a user's received and authored pair requests" do
      expect(user.my_pair_requests).to include(authored_request, received_request)
    end

    it "doesn't fetch other users' requests" do
      other_request = create(:pair_request)
      expect(user.my_pair_requests).not_to include(other_request)
    end

    it 'returns an ActiveRecord Relation' do
      expect(user.my_pair_requests).to be_a ActiveRecord::Relation
    end
  end

  describe '#my_feedback' do
    let(:user) { create(:user) }
    let!(:authored_feedback) { create(:feedback, author: user) }
    let!(:received_feedback) { create(:feedback, receiver: user) }

    it "fetches a user's received and authored feedback" do
      expect(user.my_feedback).to include(authored_feedback, received_feedback)
    end

    it "doesn't return other users' feedback" do
      other_feedback = create(:feedback)
      expect(user.my_feedback).not_to include(other_feedback)
    end

    it 'returns an ActiveRecord Relation' do
      expect(user.my_pair_requests).to be_a ActiveRecord::Relation
    end
  end

  describe '#full_name' do
    let(:user) { create(:user, first_name: 'Albert', last_name: 'Einstein') }

    it "returns the user's first and last name together in a string" do
      expected_full_name = 'Albert Einstein'
      expect(user.full_name).to eq(expected_full_name)
    end
  end

  describe '#blog_slug' do
    let(:user) { create(:user) }

    context 'when the profile has a slug' do
      before do
        user.profile.update(slug: 'test-slug')
      end

      it 'returns the slug from the user profile' do
        expect(user.blog_slug).to eq 'test-slug'
      end
    end

    context 'when the profile does not have a slug' do
      before do
        user.profile.update(slug: nil)
      end

      it 'returns the id of the user profile' do
        expect(user.blog_slug).to eq user.profile.id.to_s
      end
    end
  end
end
