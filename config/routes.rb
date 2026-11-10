Rails.application.routes.draw do
  resources :grade_course_subjects
  resources :courses
  resources :grades

  get "mypage/index"
  get "teacher_mypage/index"

  # ログイン・ログアウト
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 新規登録・ユーザー管理
  resources :users

  # 生徒側：学年・クラス・教科選択後の質問一覧
  get "/questions/classroom",
      to: "questions#classroom",
      as: :classroom_questions

  # 教師側：学年・クラス・教科の選択画面
  get "/teacher_mypage/classroom_select",
      to: "teacher_mypage#classroom_select",
      as: :teacher_classroom_select

  # 教師側：選択後の質問一覧画面
  get "/teacher_mypage/classroom_questions",
      to: "teacher_mypage#classroom_questions",
      as: :teacher_classroom_questions

  # 各モデルのルート
  resources :questions
  resources :answers
  resources :subjects
  resources :bookmarks

  # トップページ
  root "questions#index"

  # 教師側：質問削除
  delete "teacher_mypage/:id",
         to: "teacher_mypage#destroy_question",
         as: :teacher_mypage_question
end
