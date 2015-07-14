class Income < ActiveRecord::Base
  belongs_to :income_source, polymorphic: true
  belongs_to :driver
  validates :date, :income_source_id,  presence: true
  paginates_per 50

sql_join_es = "LEFT JOIN external_shops ON incomes.income_source_id=external_shops.id AND incomes.income_source_type='ExternalShop'"
sql_join_tr = "LEFT JOIN truck_routes ON incomes.income_source_id=truck_routes.id AND incomes.income_source_type='TruckRoute'"
sql_join_bs = "LEFT JOIN brand_shops ON incomes.income_source_id=brand_shops.id AND incomes.income_source_type='BrandShop'"

  scope :all_types, -> {joins(sql_join_es).joins(sql_join_tr).joins(sql_join_bs).where.not('value' => nil).order(date: :desc, income_source_type: :asc)}
  scope :external_shops, ->(day) {joins(sql_join_es).where('income_source_type' => 'ExternalShop').where(date: day).order('external_shops.name')}
  scope :truck_routes, ->(day) {joins(sql_join_tr).where('income_source_type' => 'TruckRoute').where(date: day).order('truck_routes.name')}
  scope :brand_shops, ->(day) {joins(sql_join_bs).where('income_source_type' => 'BrandShop').where(date: day).order('brand_shops.name')}
  scope :last_workdays, -> {select(:date).distinct.limit(5).order('date DESC').reverse}
end
