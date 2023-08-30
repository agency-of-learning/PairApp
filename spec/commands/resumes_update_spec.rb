# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resumes::Update do
  subject(:command) { described_class.new(user:, params:) }

  let(:user) { create(:user) }
  let(:uploaded_resume) do
    ActiveStorage::Blob.create_and_upload!(
      io: Rails.root.join('spec/fixtures/bob_resume.pdf').open,
      filename: 'bob_resume.pdf',
      content_type: 'application/pdf'
    ).signed_id
  end

  describe '#call!' do
    context 'when a new resume is uploaded' do
      let!(:existing_resume) { create(:resume, user:) }
      let(:params) do
        ActionController::Parameters.new({
          profile: { 
            resume: ActiveStorage::Blob.create_and_upload!(
              io: Rails.root.join('spec/fixtures/bob_resume.pdf').open,
              filename: 'bob_resume.pdf',
              content_type: 'application/pdf'
            ).signed_id, 
            resume_name: 'Uploaded resume',
            current_resume_id: existing_resume.id, 
          }
        }).require(:profile).permit(:resume, :resume_name, :current_resume_id)
      end 

      it 'associates the resume with the user' do
        expect { command.call! }.to change { 
          user.resumes.count 
        }.by(1)
      end

      it 'associates sets the current resume to the new resume' do
        command.call!
        uploaded_resume = Resume.find_by(name: 'Uploaded resume')
        expect(user.current_resume).to eq(uploaded_resume)
      end

      it 'sets all other resumes to not current' do
        command.call!
        expect(existing_resume.reload.current).to eq(false)
      end
    end

    context 'when a new resume is not uploaded but a different resume is selected as current' do
      let!(:existing_resume) { create(:resume, user:, current: false) }
      let!(:newer_resume) { create(:resume, user:) }
      let(:params) do
        ActionController::Parameters.new({
          profile: { 
            resume: nil,
            resume_name: '',
            current_resume_id: existing_resume.id, 
          }
        }).require(:profile).permit(:resume, :resume_name, :current_resume_id)
      end

      it 'associates sets the current resume to the new resume' do
        expect { command.call! }.to change {
          user.current_resume
        }.from(newer_resume).to(existing_resume)
      end

      it 'sets all other resumes to not current' do
        command.call!
        expect(newer_resume.reload.current).to eq(false)
      end
    end
  end
end
