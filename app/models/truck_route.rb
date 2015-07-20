class TruckRoute < ActiveRecord::Base
  has_many :incomes, as: :income_source
  has_many :drivers, through: :incomes
  validates :name, :weekdays, presence: true

  scope :weekday, ->(day) { where('weekdays LIKE ?', "%#{day}%").order(:name) }
  scope :list, -> { order(:name) }
end
