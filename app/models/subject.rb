class Subject < ApplicationRecord
  has_many :grade_course_subjects, dependent: :destroy
  has_many :grades, -> { distinct }, through: :grade_course_subjects
  has_many :courses, -> { distinct }, through: :grade_course_subjects

  validates :name, presence: true, uniqueness: true
end
