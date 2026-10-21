
Rails.application.routes.draw do
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

<<<<<<< HEAD
  # トップページ
  root "questions#index"
=======
  root 'questions#index' # トップページを任意で指定

  delete "mypage/questions/:id",
        to: "mypage#destroy_question",
        as: :mypage_question
>>>>>>> b4116ce077d8c9620400b924ee65bd465d8b97fe
end
