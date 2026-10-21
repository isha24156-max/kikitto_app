
class MypageController < ApplicationController
  before_action :require_login

  def index
    @user = current_user

    # 保存した質問
    saved_questions = @user.bookmarks
      .includes(question: :subject)
      .map(&:question)
      .compact
      .uniq

    # 自分のした質問
    my_questions = @user.questions
      .includes(:subject)
      .order(created_at: :desc)

    # ページ番号を取得
    saved_page = [params[:saved_page].to_i, 1].max
    my_page = [params[:my_page].to_i, 1].max

    # ページ数を計算（5件ずつ）
    @saved_total_pages = [(saved_questions.length / 5.0).ceil, 1].max
    @my_total_pages = [(my_questions.count / 5.0).ceil, 1].max

    # ページ数を超えないように調整
    @saved_page = [saved_page, @saved_total_pages].min
    @my_page = [my_page, @my_total_pages].min

    # 表示する質問を取得
    @saved_questions = saved_questions
      .slice((@saved_page - 1) * 5, 5) || []

    @my_questions = my_questions
      .offset((@my_page - 1) * 5)
      .limit(5)
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
