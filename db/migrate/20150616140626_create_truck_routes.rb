class CreateTruckRoutes < ActiveRecord::Migration
  def change
    create_table :truck_routes do |t|

      t.text :name, index: true
      t.text :weekdays, index: true
      t.timestamps null: false
    end
  end
end
