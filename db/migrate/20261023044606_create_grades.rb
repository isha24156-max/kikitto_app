class CreateGrades < ActiveRecord::Migration[7.2]
  def change
    create_table :grades do |t|
      t.integer :g_number

      t.timestamps
    end
  end
end
