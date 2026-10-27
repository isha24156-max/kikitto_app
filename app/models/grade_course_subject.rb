class GradeCourseSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :grade
  belongs_to :course

  has_many :questions
end
