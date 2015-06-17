class TruckRoute < ActiveRecord::Base
  has_many :incomes
  has_many :drivers, through: :incomes
  validates :name, :weekdays, presence: true
end
