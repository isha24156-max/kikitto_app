
class TeacherMypageController < ApplicationController
  before_action :require_login

  def index
    @subjects = Subject.order(:name)
  
    @selected_subject_id = params[:subject_id]
  
    @questions = Question
      .includes(:grade_course_subject, :answers)
      .order(created_at: :desc)
  
    if @selected_subject_id.present?
      @questions = @questions.joins(:grade_course_subject)
        .where(grade_course_subjects: {
          id_subjects: @selected_subject_id
        })
    end
  
    @unanswered_questions = @questions.select do |question|
      question.answers.empty?
    end
  
    @history_questions = @questions
      .joins(:answers)
      .where(answers: { user_id: current_user.id })
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
