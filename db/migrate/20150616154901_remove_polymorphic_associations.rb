class RemovePolymorphicAssociations < ActiveRecord::Migration
  def change
    remove_column :incomes, :source_id, :integer
    remove_column :incomes, :source_type, :string
  end
end
