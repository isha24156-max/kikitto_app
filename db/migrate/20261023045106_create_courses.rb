class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.integer :c_number

      t.timestamps
    end
  end
end
