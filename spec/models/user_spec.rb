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
#  role                   :integer          default("member"), not null
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
  describe 'scopes' do
    describe '.invitee_select_for' do
      let!(:param_user) { create(:user) }
      let!(:other_user) { create(:user) }

      it 'excludes the user in the param' do
        param_user_data = [param_user.email, param_user.id]
        expect(described_class.invitee_select_for(param_user)).not_to include(param_user_data)
      end

      it 'includes other users' do
        other_user_data = [other_user.email, other_user.id]
        expect(described_class.invitee_select_for(param_user)).to include(other_user_data)
      end
    end

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

    describe '#role' do
      let(:user) { build(:user) }

      it 'defaults to member' do
        expect(user.role).to eq('member')
      end

      it 'responds to member? properly' do
        expect(user.member?).to be(true)
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
  end
end
