class CreateExternalShops < ActiveRecord::Migration
  def change
    create_table :external_shops do |t|

      t.text :name, index: true
      t.boolean :daily_payments
      t.timestamps null: false
    end
  end
end
