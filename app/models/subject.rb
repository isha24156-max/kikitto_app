class Subject < ApplicationRecord
  has_many :grade_course_subjects, dependent: :destroy
end
