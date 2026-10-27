class Question < ApplicationRecord
  belongs_to :user, optional: true
  # belongs_to :subject
  belongs_to :grade_course_subject

  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end
