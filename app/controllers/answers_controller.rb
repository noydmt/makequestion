class AnswersController < ApplicationController

  def new
    @questions = Question.where(user_id: params[:user_id]);
    @answer = Answer.new
  end

  def create
    binding.pry
  end

end
