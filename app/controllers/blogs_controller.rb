class BlogsController < ApplicationController
  def show
    @author = User.find(params[:user_id])
    blog_posts = @author.blog_posts.order_newest_first

    @published_posts = blog_posts.published
    @draft_posts = blog_posts.draft if @author == current_user
  end
end
