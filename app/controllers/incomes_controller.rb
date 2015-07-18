class IncomesController < ApplicationController
  before_action :logged_in_user
  def index
    @from = from_date(params[:from])
    @to = to_date(params[:to])
    @incomes = Income.all_types.where(date: @from..@to).page(params[:page])
  end

  def new
    @income = Income.new
    data_for_form
  end

  def create
    build_income
    if @income.save
      flash[:success] = 'Income added successfully.'
      redirect_to dashboard_path(date_to_url(income_params[:date]))
    else
      data_for_form
      render 'new'
    end
  end

  def edit
    @income = Income.find(params[:id])
    data_for_form
  end

  def update
    @income = Income.find(params[:id])
    if @income.update(income_params)
      flash[:success] = 'Income updated successfully.'
      redirect_to dashboard_path(date_to_url(income_params[:date]))
    else
      render 'edit'
    end
  end

  def destroy
    income = Income.find(params[:id])
    income.destroy
    flash[:success] = 'Income removed successfully.'
    redirect_to incomes_path
  end

  def update_multiple
    if params[:incomes].nil?
      flash[:alert] = 'There is no data to save'
    else
      Income.update(params[:incomes].keys, params[:incomes].values)
      flash[:success] = 'Incomes saved successfully'
    end
    redirect_to dashboard_path(date_to_url(params[:date]))
  end

  private

  def chosen_type?(type)
    if params[:income].nil?
      if @income.income_source_type.blank?
        type == 'TruckRoute' ? true : false
      else
        type == @income.income_source_type ? true : false
      end
    else
      type == params[:income][:income_source_type] ? true : false
    end
  end

  def income_types
    [{ name: 'Truck Route', active: chosen_type?('TruckRoute'), pane: 'truck_route' },
     { name: 'Brand Shop', active: chosen_type?('BrandShop'), pane: 'brand_shop' },
     { name: 'External Shop', active: chosen_type?('ExternalShop'), pane: 'external_shop' }]
  end

  def build_income
    if params[:income][:income_source_id].empty?
      @income = Income.new(income_params)
    else      
      if params[:income][:income_source_type] == 'TruckRoute'
        income_source = TruckRoute.find(params[:income][:income_source_id])
      elsif params[:income][:income_source_type] == 'BrandShop'
        income_source = BrandShop.find(params[:income][:income_source_id])
      elsif params[:income][:income_source_type] == 'ExternalShop'
        income_source = ExternalShop.find(params[:income][:income_source_id])
      end
      @income = income_source.incomes.build(income_params)
    end   
  end

  def data_for_form
    @income_types = income_types
    @drivers = Driver.all.map { |c| ["#{c.name} #{c.surname}", c.id] }
    @truck_routes = TruckRoute.all.map { |c| [c.name, c.id] }
    @brand_shops = BrandShop.all.map { |c| [c.name, c.id] }
    @external_shops = ExternalShop.all.map { |c| [c.name, c.id] }
  end

  def income_params
    params.require(:income).permit(:value, :midday_value, :date, :driver_id, :income_source_id)
  end
end
