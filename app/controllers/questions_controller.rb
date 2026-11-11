class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :load_classroom_selection, only: %i[new create classroom]

  # 全体質問一覧・検索
  def index
    @questions = Question.all

    if params[:q].present?
      keyword = ActiveRecord::Base.sanitize_sql_like(params[:q].strip)
      @questions = @questions.where("q_content LIKE ?", "%#{keyword}%")
    end

    @questions = @questions.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  # 質問の新規作成画面
  def new
    @question = Question.new
    if @grade_course_subject
      @question.grade_course_subject_id = @grade_course_subject.id
    end
  end

  def edit
  end

# 質問の新規作成
# 質問の新規作成
# 質問の新規作成
def create
  # ログインしていなければログイン画面へ
  unless logged_in?
    redirect_to login_path, alert: "ログインしてください。"
    return
  end

  @question = Question.new(question_params)

  # 投稿した日付を自動設定
  @question.deadline = Date.current

  # ログイン中のユーザーIDを自動設定
  @question.user_id = current_user.id

  # 選択された学年・クラス・教科を設定
  if @grade_course_subject.present?
    @question.grade_course_subject_id = @grade_course_subject.id
  end

  respond_to do |format|
    if @question.save
      format.html do
        redirect_to classroom_questions_path(
          grade: @grade,
          classroom: @classroom,
          subject: @subject_number
        ), notice: "質問を作成しました。"
      end

      format.json do
        render :show, status: :created, location: @question
      end
    else
      format.html do
        render :new, status: :unprocessable_entity
      end

      format.json do
        render json: @question.errors,
               status: :unprocessable_entity
      end
    end
  end
end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "質問を更新しました。", status: :see_other }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy!

    redirect_path = if params[:from] == "mypage"
      mypage_index_path(
        grade: params[:grade],
        classroom: params[:classroom],
        subject: params[:subject]
      )
    else
      questions_path
    end

    respond_to do |format|
      format.html do
        redirect_to redirect_path,
                    notice: "質問を削除しました。",
                    status: :see_other
      end

      format.json { head :no_content }
    end
  end

# 専用クラスルーム質問一覧
# 専用クラスルーム質問一覧
def classroom
  if @grade.blank? || @classroom.blank? || @subject_number.blank?
    redirect_to questions_path,
                alert: "学年・クラス・教科をすべて選択してください。"
    return
  end

  # 選択された学年・クラス・教科の質問だけ取得
  if @grade_course_subject
    @questions = Question.where(
      grade_course_subject_id: @grade_course_subject.id
    )
  else
    @questions = Question.none
  end

  # 質問検索
  if params[:q].present?
    keyword = ActiveRecord::Base.sanitize_sql_like(
      params[:q].strip
    )

    @questions = @questions.where(
      "q_content LIKE ?",
      "%#{keyword}%"
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

  private

  def set_question
    @question = Question.find(params[:id])
  end

# パラメータから紐付けデータを判定する共通処理
# パラメータから紐付けデータを判定する共通処理
def load_classroom_selection
  @grade = params[:grade]
  @classroom = params[:classroom]
  @subject_number = params[:subject] || params[:subject_number]
  @subject = Subject.find_by(id: @subject_number)

  # 教科番号から教科名を取得
  @subject_record = Subject.find_by(id: @subject_number)

  return if @grade.blank? || @classroom.blank? || @subject_number.blank?

  grade_record = Grade.find_by(g_number: @grade)
  course_record = Course.find_by(c_number: @classroom)

  if grade_record && course_record
    # 紐付けレコードを検索
    @grade_course_subject = GradeCourseSubject.find_or_create_by(
      grade_id: grade_record.id,
      course_id: course_record.id,
      subject_id: @subject_number
    )
  end
end

  def question_params
    params.require(:question).permit(
      :deadline,
      :q_content,
      :grade_course_subject_id
    )
  end
end
