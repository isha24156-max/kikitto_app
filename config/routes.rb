
Rails.application.routes.draw do
  get "mypage/index"

  # ログイン・ログアウト
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # ユーザー管理
  resources :users

  # 学年・クラス・教科ごとの質問一覧
  get "/questions/classroom",
      to: "questions#classroom",
      as: :classroom_questions

  # 各モデルのルーティング
  resources :questions
  resources :answers
  resources :subjects
  resources :bookmarks

  # マイページの質問削除
  delete "mypage/questions/:id",
         to: "mypage#destroy_question",
         as: :mypage_question

  # トップページ
  root "questions#index"
end
