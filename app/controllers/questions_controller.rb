class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  # 質問一覧・検索
  def index
    @questions = Question.all

    # 質問内容で検索
    if params[:q].present?
      keyword = ActiveRecord::Base.sanitize_sql_like(params[:q].strip)
      @questions = @questions.where(
        "q_content LIKE ?",
        "%#{keyword}%"
      )
    end

    @questions = @questions.order(created_at: :desc)
                           .page(params[:page])
                           .per(15)
  end

  # 質問の詳細
  def show
  end

  # 質問の新規作成画面
  def new
    @question = Question.new

    if params[:grade].present? && params[:classroom].present? && params[:subject].present?
      # カラム名を grade_id, course_id, subject_id に統一
      gcs = GradeCourseSubject.find_by(
        grade_id: params[:grade],
        course_id: params[:classroom],
        subject_id: params[:subject]
      )

      @question.GradeCourseSub = gcs.id if gcs.present?
    end
  end

  # 質問の編集画面
  def edit
  end

  # 質問の新規作成
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html do
          # 渡されたパラメータがあれば該当クラスの質問一覧へリダイレクト
          if params[:grade].present? && params[:classroom].present? && params[:subject].present?
            redirect_to classroom_questions_path(
              grade: params[:grade],
              classroom: params[:classroom],
              subject: params[:subject]
            ), notice: "質問を作成しました。"
          else
            redirect_to @question, notice: "質問を作成しました。"
          end
        end

        format.json do
          render :show,
                 status: :created,
                 location: @question
        end
      else
        format.html do
          render :new, status: :unprocessable_entity
        end

        format.json do
          render json: @question.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # 質問の更新
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to @question,
                      notice: "質問を更新しました。",
                      status: :see_other
        end

        format.json do
          render :show,
                 status: :ok,
                 location: @question
        end
      else
        format.html do
          render :edit,
                 status: :unprocessable_entity
        end

        format.json do
          render json: @question.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # 質問の削除
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html do
        redirect_to questions_path,
                    notice: "質問を削除しました。",
                    status: :see_other
      end

      format.json do
        head :no_content
      end
    end
  end

  # 学年・クラス・教科ごとの専用質問一覧ページ
  def classroom
    @grade = params[:grade]
    @classroom = params[:classroom]
    @subject_number = params[:subject]

    # 選択された値が正しいか確認
    unless (1..3).cover?(@grade.to_i) &&
           (1..4).cover?(@classroom.to_i) &&
           (1..6).cover?(@subject_number.to_i)

      redirect_to questions_path,
                  alert: "学年・クラス・教科を選択してください。"
      return
    end

    # 1. カラム名を grade_id, course_id, subject_id に統一して検索
    gcs = GradeCourseSubject.find_by(
      grade_id: @grade,
      course_id: @classroom,
      subject_id: @subject_number
    )

    # 2. 接続IDが存在すればその質問のみを取得
    @questions = if gcs.present?
                   Question.where(GradeCourseSub: gcs.id)
                 else
                   Question.none
                 end

    # 3. 専用一覧画面でのキーワード検索処理
    if params[:q].present?
      keyword = ActiveRecord::Base.sanitize_sql_like(params[:q].strip)
      @questions = @questions.where("q_content LIKE ?", "%#{keyword}%")
    end

    # 4. 並び替えとペジネーション
    @questions = @questions.order(created_at: :desc)
                           .page(params[:page])
                           .per(15)
  end

  private

  # URLのIDから質問を取得
  def set_question
    @question = Question.find(params[:id])
  end

  # 保存を許可する項目
  def question_params
    params.require(:question).permit(
      :deadline,
      :q_content,
      :user_id,
      :GradeCourseSub
    )
  end
end