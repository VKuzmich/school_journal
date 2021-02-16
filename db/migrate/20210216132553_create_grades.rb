class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.string :number
      t.string :group, limit: 1

      t.timestamps
    end
  end
end
