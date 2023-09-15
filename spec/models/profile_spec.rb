# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  github_link            :string
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  linked_in_link         :string
#  location               :string
#  personal_site_link     :string
#  slug                   :string
#  twitter_link           :string
#  visibility             :integer          default("private"), not null
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

  describe 'slug validation' do
    subject(:profile) { build(:profile) }

    it 'does not allow slugs with invalid characters' do
      expect { subject.update!(slug: 'invalid.slug') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { subject.update!(slug: 'invalid slug') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { subject.update!(slug: 'invalid|slug') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#toggle_visibility!' do
    subject(:profile) { create(:profile, visibility:) }

    context 'when the profile is private' do
      let(:visibility) { :private }

      it 'changes the profile to public' do
        expect { subject.toggle_visibility! }.to change(subject, :visibility).from('private').to('public')
      end
    end

    context 'when the profile is public' do
      let(:visibility) { :public }

      it 'changes the profile to private' do
        expect { subject.toggle_visibility! }.to change(subject, :visibility).from('public').to('private')
      end
    end
  end
end
