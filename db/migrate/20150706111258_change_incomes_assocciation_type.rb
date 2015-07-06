class ChangeIncomesAssocciationType < ActiveRecord::Migration
  def up
    change_table :incomes do |t|
      t.float :midday_value
      t.references :income_source, polymorphic: true, index: true
      t.remove  :brand_shop_id, :external_shop_id, :truck_route_id
    end
  end
  def down
    change_table :incomes do |t|
      t.remove  :income_source_id, :income_source_type, :midday_value
      t.belongs_to :brand_shop, index: true
      t.belongs_to :external_shop, index: true
      t.belongs_to :truck_route, index: true
    end
  end
end
