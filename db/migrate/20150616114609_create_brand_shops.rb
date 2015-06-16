class CreateBrandShops < ActiveRecord::Migration
  def change
    create_table :brand_shops do |t|

      t.text :name, index: true
      t.timestamps null: false
    end
  end
end
