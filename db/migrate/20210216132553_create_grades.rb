class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :number
      t.string :letter, limit: 1

      t.timestamps
    end
  end
end
