class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
  end

  def edit
  end

  def update
    @feedback = Feedback.find(params[:id])

    @merged_answers = []
    Feedback::DATA_OBJECT["feedback"].each_with_index do |question, index|
      answer = params["feedback"]["data"]["feedback"][index.to_s]["answer"]
      question["answer"] = answer
      @merged_answers << question.merge("answer" => answer)
    end

    @feedback.data = { feedback: @merged_answers }
    @feedback.save!

    flash[:notice] = 'Feedback was successfully submited.'
    redirect_to feedback_path(@feedback)
  end


 

  private
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end
  def feedback_params
    params.require(:feedback).permit(:referenceable_id, :referenceable_type, :author_id, :receiver_id, :overall_rating, data: [feedback: [:answer]])
  end
end