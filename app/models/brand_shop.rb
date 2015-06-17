class BrandShop < ActiveRecord::Base
  has_many :incomes
  validates :name, presence: true
end
