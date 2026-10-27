class GradeCourseSubject < ApplicationRecord
  belongs_to :grade
  belongs_to :course
  belongs_to :subject

  validates :subject_id, uniqueness: { scope: [ :grade_id, :course_id ] }
end
