class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user

  def index
    @general_expenses = GeneralExpense.today
    @incomes_truck_routes = Income.truck_routes.today.decorate
  end
end
