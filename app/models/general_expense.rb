class GeneralExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, :value, :date,  presence: true
  paginates_per 50

  scope :autocomplete_name, ->(q) {select(:name).distinct.limit(8).where("LOWER(name) LIKE ?", "%#{q}%")}
  scope :search, ->(q) {where("LOWER(name) LIKE ?", "%#{q}%")}
  scope :list, ->(from, to) {where(date: from..to).order(date: :desc, name: :asc)}
  scope :today, -> {where(date: DateTime.now)}
end
