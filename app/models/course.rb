class Course < ApplicationRecord
  has_many :grade_course_subjects, dependent: :destroy
  has_many :grades, -> { distinct }, through: :grade_course_subjects
  has_many :subjects, -> { distinct }, through: :grade_class_subjects

  validates :c_number, presence: true, uniqueness: true
end
