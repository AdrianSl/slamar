class Income < ActiveRecord::Base
  belongs_to :brand_shop
  belongs_to :external_shop
  belongs_to :truck_route
  belongs_to :driver
end
