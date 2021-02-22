class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.integer :rate
      t.references :student, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
