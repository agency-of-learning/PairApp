class FeaturedBlogPostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :only_authorize_agent, only: :index

  def index
    @featured_blog_posts = FeaturedBlogPost.in_rank_order.blog_posts
  end

  def create
    featured_blog_post = authorize FeaturedBlogPost.new(
      featured_blog_post_params.merge({ row_order_position: :first })
    )
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
