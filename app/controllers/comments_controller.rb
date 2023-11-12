class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user! # If using Devise for user authentication

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # Redirect back to the commentable object with a success message
      redirect_to @commentable, notice: 'Comment was successfully created.'
    else
      # Handle the error, possibly re-rendering the form
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # Redirect back to the commentable object with a success message
    redirect_to @commentable, notice: 'Comment was successfully deleted.'
  end

  private

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
