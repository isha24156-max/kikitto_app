class CreateGradeCourseSubjects < ActiveRecord::Migration[7.2]
  def change
    create_table :grade_course_subjects do |t|
      t.integer :subject_id
      t.integer :course_id
      t.integer :grade_id

      t.timestamps
    end
  end
end
