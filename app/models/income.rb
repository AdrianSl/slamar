class Income < ActiveRecord::Base
  belongs_to :income_source, polymorphic: true
  belongs_to :driver
  validates :date,  presence: true

  /scope :today, -> {where(date: DateTime.now)}/
  /scope :truck_routes, -> {joins(:truck_route).where('income_source_type' => 'TrackRoute').order('truck_routes.name')}/
  /scope :brand_shops, -> {joins(:brand_shop).where('income_source_type' => 'BrandShop').order('brand_shops.name')}/
  /scope :external_shops, -> {joins(:external_shop).where('income_source_type' => 'ExternalShop').order('external_shops.name')}/
  scope :external_shops, -> {joins("LEFT JOIN external_shops ON incomes.income_source_id=external_shops.id AND incomes.income_source_type='ExternalShop'").where('income_source_type' => 'ExternalShop').order('external_shops.name')}
  scope :truck_routes, -> {joins("LEFT JOIN truck_routes ON incomes.income_source_id=truck_routes.id AND incomes.income_source_type='TruckRoute'").where('income_source_type' => 'TruckRoute').order('truck_routes.name')}
  scope :brand_shops, -> {joins("LEFT JOIN brand_shops ON incomes.income_source_id=brand_shops.id AND incomes.income_source_type='BrandShop'").where('income_source_type' => 'BrandShop').order('brand_shops.name')}
end
