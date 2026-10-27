<<<<<<< HEAD
# Rails.application.routes.draw do
# resources :grade_course_subjects
# resources :courses
# resources :grades
# get "mypage/index"
# ログイン・ログアウト用ルーティング
# get    '/login',  to: 'sessions#new'
# post   '/login',  to: 'sessions#create'
# delete '/logout', to: 'sessions#destroy'

# 新規登録・ユーザー管理
# resources :users

# 他のモデル用ルーティング
# resources :questions
# resources :answers
# resources :subjects
# resources :bookmarks

# root 'questions#index' # トップページを任意で指定
# end

=======
>>>>>>> 06896d27234dc7a12e04fa36647173d114b1d321

Rails.application.routes.draw do
  resources :grade_course_subjects
  resources :courses
  resources :grades

  get "mypage/index"
<<<<<<< HEAD

  # ログイン・ログアウト
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
=======
  get "teacher_mypage/index"

  # ログイン・ログアウト用ルーティング
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
>>>>>>> 06896d27234dc7a12e04fa36647173d114b1d321

  # 新規登録・ユーザー管理
  resources :users

  # 学年・クラス・教科を選択した後の質問一覧
  get "/questions/classroom",
      to: "questions#classroom",
      as: :classroom_questions

  # 各モデルのルート
  resources :questions
  resources :answers
  resources :subjects
  resources :bookmarks

  # トップページ
  root "questions#index"
end
