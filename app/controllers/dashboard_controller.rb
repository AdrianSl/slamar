class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user

  def index
    @chosen_date = give_date(params[:date])
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
  end

  private

    def give_date(param)
      param.nil? ? DateTime.now : param.to_date 
    end
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
