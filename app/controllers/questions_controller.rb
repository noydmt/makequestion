class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = current_user.questions.all
  end

  def new
    @questions = current_user.questions.all
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to new_question_path, success: "質問を作成しました"
    else
      @questions = current_user.questions.all
      render :new
    end
  end

  def show

  end

  def destroy
    question = Question.find_by(id: params[:id])
    if question.destroy
      redirect_to questions_path, success: "質問を削除しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render :index
    end
  end

  private 
  def question_params
    params.require(:question).permit(:content)
  end
end
