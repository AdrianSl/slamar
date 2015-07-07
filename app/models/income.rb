class Income < ActiveRecord::Base
  belongs_to :income_source, polymorphic: true
  belongs_to :driver
  validates :date, :income_source_id,  presence: true

  scope :external_shops, -> {joins("LEFT JOIN external_shops ON incomes.income_source_id=external_shops.id AND incomes.income_source_type='ExternalShop'").where('income_source_type' => 'ExternalShop').order('external_shops.name')}
  scope :truck_routes, -> {joins("LEFT JOIN truck_routes ON incomes.income_source_id=truck_routes.id AND incomes.income_source_type='TruckRoute'").where('income_source_type' => 'TruckRoute').order('truck_routes.name')}
  scope :brand_shops, -> {joins("LEFT JOIN brand_shops ON incomes.income_source_id=brand_shops.id AND incomes.income_source_type='BrandShop'").where('income_source_type' => 'BrandShop').order('brand_shops.name')}
end
