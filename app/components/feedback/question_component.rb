# frozen_string_literal: true

class Feedback::QuestionComponent < ViewComponent::Base
  def initialize(question:)
    @question = question['question']
    @answer = question['answer']
  end

  attr_reader :question, :answer

  def render?
    answer.present?
  end
end
