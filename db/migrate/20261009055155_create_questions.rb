class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.date :deadline
      t.text :q_content
      t.integer :user_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
