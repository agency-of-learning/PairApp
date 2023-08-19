require 'rails_helper'

RSpec.describe 'Profiles' do
  describe '#show' do
    let(:user) { create(:user) }
    let(:blog_post) { create(:blog_post, title: 'Blog Title') }

    before do
      sign_in user
    end

    context 'when provided a slug' do
      before do
        get "/blog_posts/#{blog_post.title.parameterize}"
      end

      it 'returns a blog post' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(blog_post.title)
      end
    end

    context 'when provided with an id' do
      before do
        get "/blog_posts/#{blog_post.id}"
      end

      it 'returns a blog post' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(blog_post.title)
      end
    end

    context 'when provided an invalid id' do
      it 'returns an error' do
        expect {
          get '/blog_posts/not-an-id'
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
