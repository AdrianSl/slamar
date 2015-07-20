class Driver < ActiveRecord::Base
  has_many :incomes
  has_many :truck_routes, through: :incomes
  validates :name, :surname, presence: true

  scope :list, -> { order(:surname, :name).decorate }
end
