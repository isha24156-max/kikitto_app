class SessionsController < ApplicationController
  def new
    # ログイン画面表示
  end

  def create
    user = User.find_by(mail: params[:session][:mail])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to questions_path # ログイン後の遷移先（マイページや質問一覧など）
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
