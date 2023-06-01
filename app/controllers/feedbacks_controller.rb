class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show edit update]

  def index; end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new; end

  def edit; end

  def update
    @feedback.update_with_json_answers!(params)

    flash[:notice] = 'Feedback was successfully submited.'
    redirect_to feedback_path(@feedback)
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit!
  end
end
