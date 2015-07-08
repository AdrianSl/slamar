class IncomesController < ApplicationController
  before_action :logged_in_user

  def new
    @income = Income.new
    @income_types = get_income_types
    @drivers = Driver.all.map{|c| [ "#{c.name} #{c.surname}", c.id ]}
    @truck_routes = TruckRoute.all.map{|c| [ c.name, c.id ]}
    @brand_shops = BrandShop.all.map{|c| [ c.name, c.id ]}
    @external_shops = ExternalShop.all.map{|c| [ c.name, c.id ]}
  end
  def create
    unless params[:income][:income_source_id].empty?
      if params[:income][:income_source_type] == "TruckRoute"
        income_source = TruckRoute.find(params[:income][:income_source_id])
      elsif params[:income][:income_source_type] == "BrandShop"
        income_source = BrandShop.find(params[:income][:income_source_id])
      elsif params[:income][:income_source_type] == "ExternalShop"
        income_source = ExternalShop.find(params[:income][:income_source_id])
      end
    end
    if income_source.nil?
      @income = Income.new(income_params)
    else
      @income = income_source.incomes.build(income_params)
    end
    if @income.save
      flash[:success] = "Income added successfully."
      redirect_to dashboard_path(date_to_url(income_params[:date]))
    else
      @income_types = get_income_types
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

    def is_chosen_type?(type)
      if params[:income].nil? 
        type == "TruckRoute" ? true : false
      else
        type == params[:income][:income_source_type] ? true : false
      end
    end
    def get_income_types
      [{ name: "Truck Route", active: is_chosen_type?("TruckRoute"), pane: "truck_route"},
       { name: "Brand Shop", active: is_chosen_type?("BrandShop"), pane: "brand_shop"},
       { name: "External Shop", active: is_chosen_type?("ExternalShop"), pane: "external_shop"}] 
    end
    def income_params
      params.require(:income).permit(:value, :midday_value, :date, :driver_id)
    end
end
