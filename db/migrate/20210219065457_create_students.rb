class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.date :birthday
      t.references :user, null: false, foreign_key: true
      t.references :grade, null: false, foreign_key: true
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
