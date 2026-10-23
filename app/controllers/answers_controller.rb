class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]

  def index
    @answers = Answer.all
    @answer = Answer.new
  end

  def show
  end

  def new
    @answer = Answer.new
  
    if params[:question_id].present?
      @question = Question.find(params[:question_id])
  
      @answers = Answer.where(question_id: params[:question_id])
                        .order(created_at: :desc)
    else
      @question = nil
      @answers = Answer.none
    end
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to question_path(@answer.question_id),
                  notice: "回答を投稿しました。"
    else
      redirect_to question_path(@answer.question_id),
                  alert: "回答を投稿できませんでした。"
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer,
                  notice: "回答を更新しました。",
                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy!

    redirect_to answers_path,
                notice: "回答を削除しました。",
                status: :see_other
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(
      :ans_content,
      :user_id,
      :question_id
    )
  end
end