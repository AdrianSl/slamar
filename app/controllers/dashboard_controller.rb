class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user

  def index
    @general_expenses = GeneralExpense.today.decorate
    @incomes_truck_routes = Income.truck_routes.today.decorate
    @incomes_brand_shops = Income.brand_shops.today.decorate
    @incomes_external_shops = Income.external_shops.today.decorate
  end
end
