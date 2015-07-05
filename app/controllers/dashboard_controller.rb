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
    @query_dates = Income.select(:date).distinct.limit(5).order('date DESC').reverse
    @dates = Array.new()
    @query_dates.each do |item|
      @dates << { active: is_chosen_date?(item.date, @chosen_date), 
                  date_name: name_of_day(item.date),
                  date_value: item.date.to_s(:db) 
                }
    end
    @general_expenses = GeneralExpense.where(date: @chosen_date).decorate
    @incomes_truck_routes = Income.truck_routes.where(date: @chosen_date).decorate
    @incomes_brand_shops = Income.brand_shops.where(date: @chosen_date).decorate
    @incomes_external_shops = Income.external_shops.where(date: @chosen_date).decorate
    @chosen_date = @chosen_date.strftime("%Y-%m-%d, %A")
    @general_expense = GeneralExpense.new
    @income = Income.new
    @external_shops = ExternalShop.all.map{|c| [ c.name, c.id ]}
    @drivers = Driver.all.map{|c| [ "#{c.name} #{c.surname}", c.id ]}
  end
  def create
    if is_workday_created?(params[:date])
      flash[:error] = "Workday already exists."
    else
      weekday = params[:date].to_date.wday
      truck_routes = TruckRoute.where("weekdays LIKE ?", "%#{weekday}%")
      truck_routes.each do |shop|
        shop.incomes.create(date: params[:date])
      end     
      brand_shops = BrandShop.all
      brand_shops.each do |shop|
        shop.incomes.create(date: params[:date])
      end
      external_shops = ExternalShop.where(daily_payments: true)
      external_shops.each do |shop|
        shop.incomes.create(date: params[:date])
      end
      flash[:success] = "New workday created successfully."
    end
    redirect_to dashboard_path(date_to_url(params[:date][:value]))
  end

  private

    def is_chosen_date?(any_date, chosen_date)
      any_date == chosen_date.to_date ? true : false
    end
    def name_of_day(any_date)
      if any_date == DateTime.now.to_date
       any_date.strftime("%a") + ', Today'
      elsif any_date  == (DateTime.now - 1.day).to_date
        any_date.strftime("%a") + ', Yesterday'
      else
        any_date.strftime("%a, %m-%d")
      end
    end

end
