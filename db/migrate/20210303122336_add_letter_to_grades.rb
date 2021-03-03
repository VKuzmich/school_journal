class AddLetterToGrades < ActiveRecord::Migration[6.1]
  def change
    add_column :grades, :letter, :string, limit: 1
  end
end
