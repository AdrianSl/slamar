class GeneralExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, :value, :date  presence: true
end
