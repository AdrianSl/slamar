class BrandShop < ActiveRecord::Base
  has_many :incomes, as: :income_source
  validates :name, presence: true

    scope :list, -> { order(:name) }
end
