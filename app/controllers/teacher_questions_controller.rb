class TeacherQuestionsController < ApplicationController
  before_action :load_classroom_selection, only: [ :index ]

  def select
  end

  def index
    if @grade.blank? || @classroom.blank? || @subject_number.blank?
      redirect_to teacher_questions_select_path,
                  alert: "学年・クラス・教科をすべて選択してください。"
      return
    end

    # 既存の紐付けデータを検索
    if @grade_course_subject
      @questions = Question
        .includes(:answers)
        .where(grade_course_subject_id: @grade_course_subject.id)
    else
      @questions = Question.none
    end

    # 質問検索
    if params[:q].present?
      keyword = ActiveRecord::Base.sanitize_sql_like(
        params[:q].strip
      )

      @questions = @questions.where(
        "q_content LIKE ?", "%#{keyword}%"
      )
    end

    # 並び替え
    case params[:sort]
    when "oldest"
      @questions = @questions.order(created_at: :asc)

    when "unanswered"
      @questions = @questions.where.missing(:answers)
                             .order(created_at: :desc)

    when "answered"
      @questions = @questions.where.associated(:answers)
                             .distinct
                             .order(created_at: :desc)

    else
      @questions = @questions.order(created_at: :desc)
    end

    # ページネーション
    @questions = @questions.page(params[:page]).per(15)
  end
  # 質問削除
  def destroy
    question = Question.find(params[:id])
    question.destroy!

    redirect_to teacher_questions_path(
  grade: params[:grade],
  classroom: params[:classroom],
  subject: params[:subject],
  q: params[:q],
  sort: params[:sort]
), notice: "質問を削除しました。"

  rescue ActiveRecord::RecordNotFound
    redirect_to teacher_questions_select_path,
                alert: "質問が見つかりません。"
  end

  private

  def load_classroom_selection
    @grade = params[:grade]
    @classroom = params[:classroom]
    @subject_number = params[:subject] || params[:subject_number]

    # 選択した教科を取得
    @subject = Subject.find_by(id: @subject_number)

    grade_record = Grade.find_by(g_number: @grade)
    course_record = Course.find_by(c_number: @classroom)

    if grade_record && course_record && @subject_number.present?
      @grade_course_subject = GradeCourseSubject.find_by(
        grade_id: grade_record.id,
        course_id: course_record.id,
        subject_id: @subject_number
      )
    end
  end
end
