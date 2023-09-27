class ChangeColumnNameGrades < ActiveRecord::Migration[6.1]
  def change
    rename_column :grades, :group, :letter
  end
end
