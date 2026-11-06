class GradeCourseSubject < ApplicationRecord
  # テーブル名を実際のDB名（小文字・複数形）に指定
  self.table_name = "grade_course_subjects"

  has_many :questions, foreign_key: "GradeCourseSub"

  belongs_to :grade, foreign_key: "id_grades", optional: true
  belongs_to :course, foreign_key: "id_Course", optional: true
  belongs_to :subject, foreign_key: "id_subjects", optional: true
end