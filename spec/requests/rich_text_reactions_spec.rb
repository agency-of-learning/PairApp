require 'rails_helper'

RSpec.describe 'RichTextReaction requests' do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST /rich_text_reactions' do
    it 'creates a rich text reaction' do
      expect {
        post rich_text_reactions_url,
          params: {
            rich_text_reaction: {
              emoji_caption: RichTextReaction.emoji_captions.first,
              rich_text_id: create(:standup_meeting).yesterday_work_description.id
            },
            format: :turbo_stream
          }
      }.to change(RichTextReaction, :count).by 1
      expect(response).to have_http_status :created
    end

    it 'sets a flash message to indicate failure to create' do
      post rich_text_reactions_url,
        params: {
          rich_text_reaction: {
            emoji_caption: RichTextReaction.emoji_captions.first,
            rich_text_id: 2
          },
          format: :turbo_stream
        }

      expect(flash.now[:alert]).to be_present
    end
  end

  describe 'DELETE /rich_text_reactions/:id' do
    it 'deletes a rich text reaction' do
      id = create(:rich_text_reaction).id

      expect {
        delete rich_text_reaction_url(id),
          params: {
            format: :turbo_stream
          }
      }.to change(RichTextReaction, :count).by(-1)
      expect(response).to have_http_status :no_content
    end

    it 'sets a flash message to indicate failure to delete' do
      fake_id = '1'
      rich_text_reaction = instance_double(RichTextReaction, destroy: false)
      allow(RichTextReaction).to receive(:find).with(fake_id).and_return(rich_text_reaction)

      delete rich_text_reaction_url(fake_id),
        params: {
          format: :turbo_stream
        }

      expect(flash.now[:alert]).to be_present

      expect(response).to have_http_status :no_content
    end
  end
end
