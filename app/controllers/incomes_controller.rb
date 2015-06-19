class IncomesController < ApplicationController
  before_action :logged_in_user

  def new
    @income = Income.new
    @drivers = Driver.all.map{|c| [ "#{c.name} #{c.surname}", c.id ]}
    @truck_routes = TruckRoute.all.map{|c| [ c.name, c.id ]}
    @brand_shops = BrandShop.all.map{|c| [ c.name, c.id ]}
    @external_shops = ExternalShop.all.map{|c| [ c.name, c.id ]}
  end
  def create
    @income = Income.new(income_params)
    if @income.save
      flash[:success] = "Income added successfully."
      redirect_to root_path
    else
      @drivers = Driver.all.map{|c| [ c.full_name, c.id ]}
      @truck_routes = TruckRoute.all.map{|c| [ c.name, c.id ]}
      @brand_shops = BrandShop.all.map{|c| [ c.name, c.id ]}
      @external_shops = ExternalShop.all.map{|c| [ c.name, c.id ]}
      render 'new'
    end
  end

  private

  def income_params
    params.require(:income).permit(:value, :date, :brand_shop_id, :external_shop_id, :truck_route_id, :driver_id)
  end
end
