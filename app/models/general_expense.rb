class GeneralExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, :value, :date,  presence: true

  default_scope {order(:name)}
  scope :today, -> {where(date: DateTime.now)}
end
