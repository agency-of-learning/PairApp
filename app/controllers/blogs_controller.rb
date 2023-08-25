class BlogsController < ApplicationController
  def show
    @author = Profile.friendly.find(params[:slug]).user
    blog_posts = @author.blog_posts

    @published_posts = blog_posts.published
    @draft_posts = blog_posts.draft if @author == current_user
  end
end
