class Income < ActiveRecord::Base
  belongs_to :brand_shop
  belongs_to :external_shop
  belongs_to :truck_route
  belongs_to :driver
  validates :value, :date,  presence: true

  scope :today, -> {where(date: DateTime.now)}
  scope :truck_routes, -> {joins(:truck_route).where.not('truck_route_id' => nil).order('truck_routes.name')}
  scope :brand_shops, -> {joins(:brand_shop).where.not('brand_shop_id' => nil).order('brand_shops.name')}
  scope :external_shops, -> {joins(:external_shop).where.not('external_shop_id' => nil).order('external_shops.name')}
end
