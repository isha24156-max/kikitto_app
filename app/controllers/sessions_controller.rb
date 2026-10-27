class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email] # フォームのフィールド名に合わせて変更してください (:mail など)
    password = params[:password]

    # 1. 未入力チェック
    if email.blank? || password.blank?
      flash.now[:alert] = "メールアドレスとパスワードを入力してください"
      render :new, status: :unprocessable_entity
      return
    end

    # 2. ユーザー検索 & パスワード照合
    user = User.find_by(mail: email) # DBのカラム名が mail の場合
    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to questions_path, notice: "ログインしました"
    else
      # 3. 不一致エラー
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "ログアウトしました"
  end
end
