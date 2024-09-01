class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    questions = Question.active.includes(:categories).all
    render json: questions.as_json(include: :categories), status: :ok
  end

  def create
    question = Question.new(question: question_params[:question], answer: question_params[:answer])

    if question.save && !question_params[:categories].empty?
      question_params[:categories].each do |category_id|
        CategoriesQuestion.create(category_id: category_id, question_id: question.id)
      end
      render json: question, status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  def update
    question =  Question.find_by(id: params[:id])

    if question
      question.question = params[:question]
      question.answer = params[:answer]
    end

    if question&.save!
      render json: question.as_json(include: :categories), status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])

    if question&.destroy
      head :no_content
    else
      render json: { error: "Failed to delete question" }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.permit(:question, :answer, categories: [])
  end
end
