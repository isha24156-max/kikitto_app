class RenameSubiectNameToSubjectNameInSubjects < ActiveRecord::Migration[7.2]
  def change
    rename_column :subjects, :subiect_name, :subject_name
  end
end
