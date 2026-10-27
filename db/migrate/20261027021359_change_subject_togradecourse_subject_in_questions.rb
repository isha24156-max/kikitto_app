class ChangeSubjectTogradecourseSubjectInQuestions < ActiveRecord::Migration[7.2]
  def change
    remove_reference :questions, :subject, foreign_key: false
    add_reference :questions, :grade_course_subject, foreign_key: true
  end
end
