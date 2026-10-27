class TeacherMypageController < ApplicationController
  def index
    @questions = Question.includes(:subject).order(created_at: :desc)
  end
end
