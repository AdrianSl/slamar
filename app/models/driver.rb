class Driver < ActiveRecord::Base
  has_many :incomes
  has_many :truck_routes, through: :incomes
end
