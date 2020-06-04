class AnswersController < ApplicationController

  def new
    @questions = Question.where(user_id: params[:user_id])
    @answer = Answer.new
  end

  def create
    @questions = Question.where(user_id: params[:user_id])
    for question in @questions do
      id = (question.id).to_s
      new_answer = answer_params[id]
      answer = Answer.new(question_id: question.id, content: new_answer)
      if !answer.save
        redirect_to root_path and return
      end
    end
    redirect_to root_path, notice:'回答ありがとうございました'
  end

  private
  def answer_params
    params.require(:answer)
  end
end
