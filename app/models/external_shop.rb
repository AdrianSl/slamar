class ExternalShop < ActiveRecord::Base
  has_many :incomes, as: :income_source
  validates_presence_of :name
  validates_inclusion_of :daily_payments, in: [true, false]

  scope :daily_payments, -> { where(daily_payments: true).order(:name) }
  scope :list, -> { order(:name) }
end
