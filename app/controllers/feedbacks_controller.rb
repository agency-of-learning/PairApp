class FeedbacksController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    # @feedback.data.to_json
    @feedback = Feedback.update(feedback_params)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:data, :referenceable_id, :referenceable_type, :author_id, :receiver_id, :overall_rating)
  end
end