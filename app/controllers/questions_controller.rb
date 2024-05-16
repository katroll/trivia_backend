class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    questions = Question.includes(:categories).all
    render json: questions.as_json(include: :categories), status: :ok
  end

  def create
    question = Question.new(question: question_params[:question], answer: question_params[:answer])
    category = Category.find_by(id: question_params[:category].to_i)

    if question.save
      queston.categories << category unless category.nil?
      render json: question, status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.permit(:question, :answer, :catogory)
  end
end
