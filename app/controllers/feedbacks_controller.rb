class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show edit update]

  def index
    filter = params[:filter] == 'received' ? :received_feedbacks : :authored_feedbacks
    @feedback = current_user.public_send(filter)
  end

  def show
    authorize @feedback
  end

  def edit
    authorize @feedback
  end

  def update
    authorize @feedback

    if @feedback.update_with_json_answers(params)
      flash[:notice] = 'Feedback was successfully submitted.'
      redirect_to feedback_path(@feedback)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params
      .require(:feedback)
      .permit(
        :author,
        :overall_rating,
        data: {
          feedback: [:answer]
        }
      )
  end
end
