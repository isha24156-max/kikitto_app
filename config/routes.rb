Rails.application.routes.draw do
  resources :grade_course_subjects
  resources :courses
  resources :grades
  get "mypage/index"
  # ログイン・ログアウト用ルーティング
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 新規登録・ユーザー管理
  resources :users

  # 他のモデル用ルーティング
  resources :questions
  resources :answers
  resources :subjects
  resources :bookmarks

  # トップページ
  root "questions#index" # トップページを任意で指定
end
