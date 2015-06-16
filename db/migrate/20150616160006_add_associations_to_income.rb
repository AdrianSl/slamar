class AddAssociationsToIncome < ActiveRecord::Migration
  def change
    change_table :incomes do |t|

      t.belongs_to :brand_shop, index: true
      t.belongs_to :external_shop, index: true
      t.belongs_to :truck_route, index: true
      t.belongs_to :driver, index: true
    end
  end
end
