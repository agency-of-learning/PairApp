class BlogPostsController < ApplicationController
  def show
    @blog_post = authorize BlogPost.find(params[:id])
  end

  def new
    @blog_post = authorize BlogPost.new
  end

  def edit
    @blog_post = authorize current_user.blog_posts.find(params[:id])
  end

  def create
    @blog_post = authorize current_user.blog_posts.new(blog_post_params)

    if @blog_post.save
      redirect_to @blog_post, notice: 'Post successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @blog_post = authorize current_user.blog_posts.find(params[:id])

    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: 'Post succesfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post = authorize current_user.blog_posts.find(params[:id])
    @blog_post.destroy!

    redirect_to blog_path(current_user), notice: 'Post deleted!'
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :status)
  end
end
