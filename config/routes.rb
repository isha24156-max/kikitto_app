
Rails.application.routes.draw do
  resources :grade_course_subjects
  resources :courses
  resources :grades
  get "mypage/index"

  # ログイン・ログアウト用ルーティング
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 新規登録・ユーザー管理
  resources :users

  # ★ 学年・クラス・教科ごとの専用質問一覧
  # resources :questions より前に書く
  get "/questions/classroom",
      to: "questions#classroom",
      as: :classroom_questions

  # 他のモデル用ルーティング
  resources :questions
  resources :answers
  resources :subjects
  resources :bookmarks

  # トップページ
  root "questions#index"
end
