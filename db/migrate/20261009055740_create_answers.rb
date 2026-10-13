class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.text :ans_content
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
