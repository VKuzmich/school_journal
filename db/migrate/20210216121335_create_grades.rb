class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :grade
      t.string :grade_group

      t.timestamps
    end
  end
end
