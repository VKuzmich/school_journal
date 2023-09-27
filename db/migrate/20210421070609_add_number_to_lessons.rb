class AddNumberToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :number, :integer
  end
end
