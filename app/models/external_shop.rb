class ExternalShop < ActiveRecord::Base
  has_many :incomes, as: :source
end
