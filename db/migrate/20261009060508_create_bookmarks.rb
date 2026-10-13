class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
