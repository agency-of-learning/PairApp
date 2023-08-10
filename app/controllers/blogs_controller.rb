class BlogsController < ApplicationController
  def show
    @author = User.find(params[:user_id])
    @published_posts = @author.blog_posts.published

    @draft_posts = @author.blog_posts.draft if @author == current_user
  end
end
