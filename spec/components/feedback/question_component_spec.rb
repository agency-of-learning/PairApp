# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback::QuestionComponent, type: :component do
  let(:question_with_answer) { { 'question' => 'What is the answer?', 'answer' => 'Answer' } }
  let(:question_without_answer) { { 'question' => 'What is the answer?', 'answer' => '' } }

  it "renders nothing when there's no answer" do
    render_inline(described_class.new(question: question_without_answer))

    expect(page).not_to have_selector('body')
  end

  it 'renders the question and answer when the answer exists' do
    render_inline(described_class.new(question: question_with_answer))

    expected_question = question_with_answer['question']
    expected_answer = question_with_answer['answer']
    expect(page).to have_content(expected_question)
    expect(page).to have_content(expected_answer)
  end
end
