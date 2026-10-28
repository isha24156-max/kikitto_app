class GradeCourseSubject < ApplicationRecord
  # テーブル名を指定（スネークケース変換の差異を防ぐため）
  self.table_name = "GradeCourseSubject"

  has_many :questions, foreign_key: "GradeCourseSub"
  belongs_to :grade, foreign_key: "id_grades"
  belongs_to :course, foreign_key: "id_Course"
  belongs_to :subject, foreign_key: "id_subjects"
end