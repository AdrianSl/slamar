class CreateGeneralExpenses < ActiveRecord::Migration
  def change
    create_table :general_expenses do |t|
      t.text :name, index: true
      t.float :value
      t.date :date, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :general_expenses, :users
  end
end
