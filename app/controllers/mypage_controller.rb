class MypageController < ApplicationController
  before_action :require_login

  def index
    @user = current_user

    # 保存した質問
    saved_bookmarks = @user.bookmarks
      .includes(question: :grade_course_subject)
      .select { |bookmark| bookmark.question.present? }

    # 自分のした質問
    my_questions = @user.questions
      .includes(:grade_course_subject)
      .order(created_at: :desc)

    # ページ番号を取得
    saved_page = [params[:saved_page].to_i, 1].max
    my_page = [params[:my_page].to_i, 1].max

    # 1ページに表示する件数
    per_page = 10

    # ページ数を計算（10件ずつ）
    @saved_total_pages = [(saved_bookmarks.length / per_page.to_f).ceil, 1].max
    @my_total_pages = [(my_questions.count / per_page.to_f).ceil, 1].max

    # ページ数を超えないように調整
    @saved_page = [saved_page, @saved_total_pages].min
    @my_page = [my_page, @my_total_pages].min

    # 表示するブックマークを取得
    @saved_bookmarks = saved_bookmarks
      .slice((@saved_page - 1) * per_page, per_page) || []

    # 表示する質問を取得
    @saved_questions = @saved_bookmarks.map(&:question).compact

    # 自分のした質問を取得
    @my_questions = my_questions
    .offset((@my_page - 1) * per_page)
    .limit(per_page)

  end

  def destroy_question
    question = current_user.questions.find(params[:id])
    question.destroy!
  
    redirect_to mypage_index_path,
                notice: "質問を削除しました。"
  rescue ActiveRecord::RecordNotFound
    redirect_to mypage_index_path,
                alert: "質問が見つかりません。"
  end
end
