class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|

      t.float :value
      t.date :date, index: true
      t.integer :source_id
      t.string :source_type
      t.timestamps null: false
    end
  end
end
