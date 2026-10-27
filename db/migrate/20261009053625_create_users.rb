


class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :mail
      t.string :name
      t.integer :password
      t.boolean :done

      t.timestamps
    end
  end
end
