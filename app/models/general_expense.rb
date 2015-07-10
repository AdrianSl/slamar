class GeneralExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, :value, :date,  presence: true

  scope :list, -> {order(date: :desc, name: :asc)}
  scope :today, -> {where(date: DateTime.now)}
end
