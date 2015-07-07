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
      redirect_to dashboard_path(date_to_url(income_params[:date]))
    else
    @drivers = Driver.all.map{|c| [ "#{c.name} #{c.surname}", c.id ]}
    @truck_routes = TruckRoute.all.map{|c| [ c.name, c.id ]}
    @brand_shops = BrandShop.all.map{|c| [ c.name, c.id ]}
    @external_shops = ExternalShop.all.map{|c| [ c.name, c.id ]}
      render 'new'
    end
  end
  def update_multiple
    if params[:incomes].nil?
      flash[:alert] = "There is no data to save"
    else  
      Income.update(params[:incomes].keys, params[:incomes].values)  
      flash[:success] = "Incomes saved successfully"
    end  
    redirect_to dashboard_path(date_to_url(params[:date]))
  end

  private

  def income_params
    params.require(:income).permit(:value, :midday_value, :date, :income_source_id, :income_source_type, :driver_id)
  end
end
