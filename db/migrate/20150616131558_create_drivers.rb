class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|

      t.text :name, index: true
      t.text :surname, index: true
      t.timestamps null: false
    end
  end
end
