class Income < ActiveRecord::Base
  belongs_to :brand_shop
  belongs_to :external_shop
  belongs_to :truck_route
  belongs_to :driver

  scope :today, -> {where(date: DateTime.now)}
  scope :truck_routes, -> {joins(:truck_route).where.not('truck_route_id' => nil).order('truck_routes.name')}
end
