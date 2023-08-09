# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  location               :string
#  slug                   :string
#  work_model_preferences :enum             is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_profiles_on_slug     (slug) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile do
  describe '#work_model_preferences' do
    subject(:profile) { build(:profile, work_model_preferences: preferences) }

    context 'with accepted keys and no duplicates' do
      let(:preferences) { %w[remote hybrid onsite] }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'with duplicate keys' do
      let(:preferences) { %w[remote hybrid remote] }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end

    context 'with a key that is not a valid work model' do
      let(:preferences) { %w[remote invalid] }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
