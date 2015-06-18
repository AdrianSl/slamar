class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user

  def index
    @general_expenses = GeneralExpense.select("name, value").where(date: DateTime.now).order(name: :asc)
  end
end
