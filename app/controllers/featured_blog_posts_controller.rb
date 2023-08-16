class FeaturedBlogPostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @featured_blog_posts = BlogPost.all_featured
  end

  def create
    featured_blog_post = FeaturedBlogPost.new(featured_blog_post_params)
    authorize featured_blog_post
    featured_blog_post.save!

    redirect_to featured_blog_posts_path, notice: 'Post added to Featured Blog!'
  end

  def destroy
    featured_blog_post = FeaturedBlogPost.find(params[:id])
    authorize featured_blog_post
    featured_blog_post.destroy!

    redirect_to featured_blog_posts_path, notice: 'Post removed from Featured Blog!'
  end

  private

  def featured_blog_post_params
    params.require(:featured_blog_post).permit(:blog_post_id)
  end
end
