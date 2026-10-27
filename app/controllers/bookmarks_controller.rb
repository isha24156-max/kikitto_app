
class BookmarksController < ApplicationController
  before_action :require_login, only: %i[index create destroy]
  before_action :set_bookmark, only: %i[show edit update destroy]

  def index
    @bookmarks = Bookmark.where(user_id: session[:user_id])
                         .includes(:question)
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def create
    question = Question.find_by(id: params[:question_id])

    unless question
      redirect_back fallback_location: questions_path,
                    alert: "質問が見つかりません。"
      return
    end

    @bookmark = Bookmark.find_or_create_by(
      user_id: session[:user_id],
      question_id: question.id
    )

    if @bookmark.persisted?
      redirect_back fallback_location: questions_path,
                    notice: "ブックマークに保存しました。"
    else
      redirect_back fallback_location: questions_path,
                    alert: "ブックマークを保存できませんでした。"
    end
  end

  def update
    unless @bookmark.user_id == session[:user_id]
      redirect_to questions_path, alert: "操作できません。"
      return
    end

    if @bookmark.update(bookmark_params.except(:user_id))
      redirect_to bookmarks_path, notice: "ブックマークを更新しました。"
    else
      redirect_to bookmarks_path, alert: "更新できませんでした。"
    end
  end

  def destroy
    unless @bookmark.user_id == session[:user_id]
      redirect_to questions_path, alert: "操作できません。"
      return
    end

    @bookmark.destroy
    redirect_back fallback_location: mypage_index_path,
                  notice: "ブックマークを解除しました。"
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:question_id)
  end
end
