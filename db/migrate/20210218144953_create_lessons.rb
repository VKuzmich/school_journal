class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :home_task
      t.string :description
      t.date :date_at
      t.references :subject, null: false, foreign_key: true
      t.references :grade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
