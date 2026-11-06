
class TeacherMypageController < ApplicationController
  before_action :require_login

  def index
    @questions = Question
      .includes(:grade_course_subject, :answers)
      .order(created_at: :desc)

    @unanswered_questions = @questions.select do |question|
      question.answers.empty?
    end

    @history_questions = Question
      .joins(:answers)
      .where(answers: { user_id: current_user.id })
      .includes(:grade_course_subject, :answers)
      .distinct
      .order(created_at: :desc)
  end

  def destroy_question
    question = Question.find(params[:id])
    question.destroy!
  
    redirect_to teacher_mypage_index_path(view: "all"),
                notice: "質問を削除しました。"
  rescue ActiveRecord::RecordNotFound
    redirect_to teacher_mypage_index_path(view: "all"),
                alert: "質問が見つかりません。"
  end
end
