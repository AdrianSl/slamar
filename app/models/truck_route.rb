class TruckRoute < ActiveRecord::Base
  has_many :incomes
  has_many :drivers, through: :incomes
end
