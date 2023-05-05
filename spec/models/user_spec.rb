# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("member"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  describe '::invitee_select_for' do
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

  describe '#all_pair_requests' do
    let!(:user) { create(:user) }
    let!(:authored_request) { create(:pair_request, author: user) }
    let!(:received_request) { create(:pair_request, invitee: user) }

    it "fetches a user's received and authored pair requests" do
      expect(user.all_pair_requests).to include(authored_request, received_request)
    end

    it "doesn't return include user's requests" do
      other_request = create(:pair_request)
      expect(user.all_pair_requests).not_to include(other_request)
    end

    it 'returns an ActiveRecord Relation' do
      expect(user.all_pair_requests).to be_a ActiveRecord::Relation
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
end
