# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::Update do
  subject(:command) { described_class.new(form:) }

  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  let(:form) { ProfileForm.new(profile:, user:) }
  let(:uploaded_resume) do
    ActiveStorage::Blob.create_and_upload!(
      io: Rails.root.join('spec/fixtures/bob_resume.pdf').open,
      filename: 'bob_resume.pdf',
      content_type: 'application/pdf'
    )
  end

  describe '#call!' do
    context 'when a new resume is uploaded' do
      before do
        form.resume = uploaded_resume.signed_id
        form.resume_name = 'Uploaded resume'
      end

      it 'associates the resume with the user' do
        expect { command.call! }.to change { user.resumes.count }.by(1)
      end

      it 'associates sets the current resume to the new resume' do
        existing_resume = create(:resume, user:)
        command.call!
        uploaded_resume = Resume.find_by(name: 'Uploaded resume')
        expect(user.current_resume).to eq(uploaded_resume)
      end

      it 'sets all other resumes to not current' do
        existing_resume = create(:resume, user:)
        command.call!
        expect(existing_resume.reload.current).to eq(false)
      end
    end

    context 'when a new resume is not uploaded but a different resume is selected as current' do
      let!(:existing_resume) { create(:resume, user:, current: false) }
      let!(:newer_resume) { create(:resume, user:) }

      it 'associates sets the current resume to the new resume' do
        form.current_resume_id = existing_resume.id
        expect { command.call! }.to change {
          user.current_resume
        }.from(newer_resume).to(existing_resume)
      end

      it 'sets all other resumes to not current' do
        form.current_resume_id = existing_resume.id
        command.call!
        expect(newer_resume.reload.current).to eq(false)
      end
    end

    context 'when a profile is updated' do
      it 'updates the profile details' do
        form.bio = 'New bio'
        expect { command.call! }.to change { profile.reload.bio }.to('New bio')
      end
    end
  end
end
