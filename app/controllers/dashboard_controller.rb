class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user
  include DashboardHelper

  def index
    today = date_to_url(DateTime.now)
    redirect_to dashboard_path(today)
  end

  def show
    @chosen_date = params[:id].to_date
    last_workdays_data(@chosen_date)
    fetch_data(@chosen_date)
    @general_expense = GeneralExpense.new
  end

  def create
    if workday_created?(params[:date])
      flash[:error] = 'Workday already exists.'
    else
      create_workday_elements(params[:date])
      flash[:success] = 'New workday created successfully.'
    end
    redirect_to dashboard_path(date_to_url(params[:date]))
  end

  private

  def last_workdays_data(day)
    query_dates = Income.last_workdays
    @dates = []
    query_dates.each do |item|
      @dates << { active: chosen_date?(item.date, day),
                  date_name: name_of_day(item.date),
                  date_value: item.date.to_s(:db) }
    end
  end

  def fetch_data(day)
    @general_expenses = GeneralExpense.day_list(day).decorate
    @incomes_truck_routes = Income.truck_routes(day).decorate
    @incomes_brand_shops = Income.brand_shops(day).decorate
    @incomes_external_shops = Income.external_shops(day).decorate
    @drivers = Driver.all.map { |c| ["#{c.name} #{c.surname}", c.id] }
  end

  def chosen_date?(any_date, chosen_date)
    any_date == chosen_date.to_date ? true : false
  end

  def name_of_day(any_date)
    if any_date == DateTime.now.to_date
      any_date.strftime('%a') + ', Today'
    elsif any_date == (DateTime.now - 1.day).to_date
      any_date.strftime('%a') + ', Yesterday'
    else
      any_date.strftime('%a, %m-%d')
    end
  end

  def create_workday_elements(day)
    truck_routes = TruckRoute.weekday(day.to_date.wday)
    brand_shops = BrandShop.all
    external_shops = ExternalShop.daily_payments
    data = [truck_routes, brand_shops, external_shops]
    data.each do |item|
      item.each do |shop|
        shop.incomes.create(date: day)
      end
    end
  end
end
