class RemoveGroupFromGrades < ActiveRecord::Migration[6.1]
  def change
    remove_column :grades, :group, :string
  end
end
