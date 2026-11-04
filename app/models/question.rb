class Question < ApplicationRecord
  belongs_to :grade_course_subject,
              foreign_key: "grade_course_subject_id",
              optional: true

  belongs_to :user, foreign_key: "user_id"

  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end